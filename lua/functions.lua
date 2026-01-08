local M = {}
local cached_gblame_wins = {}

function M.center_cursor_horizontally()
	local win_width = vim.api.nvim_win_get_width(0)
	local current_col = vim.fn.virtcol(".")
	local new_leftcol = current_col - math.floor(win_width / 2)
	if new_leftcol < 0 then
		new_leftcol = 0
	end
	vim.fn.winrestview({ leftcol = new_leftcol })
end

function M.format_file()
	local view = vim.fn.winsaveview()
	vim.cmd("normal! ggVG=")
	vim.fn.winrestview(view)
end

function M.fugitive_diff_is_open()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		local buf = vim.api.nvim_win_get_buf(win)
		local name = vim.api.nvim_buf_get_name(buf)
		if name:match("fugitive://") then
			return true
		end
	end
	return false
end

function M.toggle_fugitive_diff()
	if M.fugitive_diff_is_open() then
		-- Fermer tous les diffs Fugitive
		vim.cmd("diffoff!")
		-- Fermer les buffers fugitive dédiés au diff
		for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
			local buf = vim.api.nvim_win_get_buf(win)
			local name = vim.api.nvim_buf_get_name(buf)
			if name:match("fugitive://") then
				vim.api.nvim_win_close(win, true)
			end
		end
	else
		-- Ouvrir le diff Git
		vim.cmd("Gvdiffsplit")
	end
	vim.api.nvim_command("normal! zz")
end

function M.toggle_gblame()
	if #cached_gblame_wins > 0 then
		for _, win in ipairs(cached_gblame_wins) do
			if vim.api.nvim_win_is_valid(win) then
				pcall(vim.api.nvim_win_close, win, true)
			end
		end
		cached_gblame_wins = {}
		return
	end

	vim.cmd("Git blame")

	vim.schedule(function()
		local wins = {}
		for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
			local ok, buf = pcall(vim.api.nvim_win_get_buf, win)
			if ok and buf then
				local name = vim.api.nvim_buf_get_name(buf) or ""
				local ok2, ft = pcall(vim.api.nvim_buf_get_option, buf, "filetype")
				ft = (ok2 and ft) and ft or ""
				-- On considère comme Fugitive/blame les buffers fugitive ou les filetypes liés
				if name:match("fugitive://") or ft:match("fugitive") or ft:match("git") then
					table.insert(wins, win)
				end
			end
		end
		cached_gblame_wins = wins
	end)
end


M.toggle_copilot = function()
  if vim.g.copilot_enabled == 1 then
    vim.cmd("Copilot disable")
    vim.notify("Copilot disabled", vim.log.levels.INFO)
  else
    vim.cmd("Copilot enable")
    vim.notify("Copilot enabled", vim.log.levels.INFO)
  end
end

-- Chemin vers le fichier qui stockera le nom du thème persistant
local theme_persistence_file = vim.fn.stdpath("data") .. "/theme_persistence.lua"

-- Fonction pour charger le thème au démarrage
M.load_last_theme = function()
	if vim.fn.filereadable(theme_persistence_file) == 1 then
		local success, _ = pcall(dofile, theme_persistence_file)
		if not success then
			print("Error: Problem while loading the last theme.")
		end
	end
end

local original_notify = vim.notify

vim.notify = function(msg, levels, opts)
	if msg:match("position_encoding param is required") then
		return
	end
  original_notify(msg, levels, opts)
end

M.functions_in_buffer = function()
	require("telescope.builtin").lsp_document_symbols({
		symbols = { "Function", "Method" },
	})
end

-- La fonction principale du Switcher
M.theme_switcher = function()
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local builtin = require("telescope.builtin")

	builtin.colorscheme({
		-- Configuration de la fenêtre (taille demandée)
		layout_strategy = "center", -- 'center' est souvent mieux pour les petites fenêtres
		layout_config = {
			width = 0.3,
			height = 0.4,
		},
		enable_preview = false, -- Prévisualiser en scrollant (comportement par défaut)

		-- On surcharge l'action de la touche "Entrée"
		attach_mappings = function(prompt_bufnr, _)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)

				-- Récupérer le thème sélectionné
				local selection = action_state.get_selected_entry()
				local theme_name = selection.value

				-- 1. Appliquer le thème immédiatement
				vim.cmd("colorscheme " .. theme_name)

				local current_bg = vim.o.background

				-- 2. Sauvegarder pour le prochain démarrage
				local file = io.open(theme_persistence_file, "w")
				if file then
					file:write('vim.cmd("colorscheme ' .. theme_name .. '")\n')
					file:write('vim.o.background = "' .. current_bg .. '"\n')
					file:close()
					print("Thème sauvegardé : " .. theme_name)
				else
					print("Erreur : Impossible de sauvegarder le thème.")
				end
			end)
			return true
		end,
	})
end

M.toggle_zen_mode = function(zen_mode)
	local original_notify = vim.notify
	if not zen_mode.active then
		zen_mode.original = {
			cmdheight = vim.o.cmdheight,
			laststatus = vim.o.laststatus,
			showtabline = vim.o.showtabline,
			number = vim.o.number,
			relativenumber = vim.o.relativenumber,
			signcolumn = vim.o.signcolumn,
			shortmess = vim.o.shortmess,
			ruler = vim.o.ruler,
			showcmd = vim.o.showcmd,
			showmode = vim.o.showmode,
		}

		local main_win = vim.api.nvim_get_current_win()

		vim.o.cmdheight = 0
		vim.o.laststatus = 0
		vim.o.showtabline = 0
		vim.o.number = false
		vim.o.relativenumber = false
		vim.o.signcolumn = "no"
		vim.o.ruler = false
		vim.o.showcmd = false
		vim.o.showmode = false
		vim.o.shortmess = "aWFI"

		vim.notify = function() end

		-- optional Fehler ausblenden
		vim.diagnostic.hide()

		require("marks").toggle_signs()
		require("gitsigns").toggle_signs()

		-- Créer marges
		local margin = math.floor((vim.o.columns - 100) / 3)
		if margin > 0 then
			zen_mode.buf = vim.api.nvim_create_buf(false, true)

			for _, pos in ipairs({ "left", "right" }) do
				local win = vim.api.nvim_open_win(zen_mode.buf, false, {
					split = pos,
					width = margin,
					style = "minimal",
				})
				vim.wo[win].winfixwidth = true
				table.insert(zen_mode.wins, win)
			end

			vim.api.nvim_set_current_win(main_win)
		end

		zen_mode.active = true
	else
		vim.o.cmdheight = zen_mode.original.cmdheight
		vim.o.laststatus = zen_mode.original.laststatus
		vim.o.showtabline = zen_mode.original.showtabline
		vim.o.number = zen_mode.original.number
		vim.o.relativenumber = zen_mode.original.relativenumber
		vim.o.signcolumn = zen_mode.original.signcolumn
		vim.o.shortmess = zen_mode.original.shortmess
		vim.o.ruler = zen_mode.original.ruler
		vim.o.showcmd = zen_mode.original.showcmd
		vim.o.showmode = zen_mode.original.showmode

		for _, win in ipairs(zen_mode.wins) do
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_close(win, true)
			end
		end
		if zen_mode.buf and vim.api.nvim_buf_is_valid(zen_mode.buf) then
			vim.api.nvim_buf_delete(zen_mode.buf, { force = true })
		end
		zen_mode.wins, zen_mode.buf = {}, nil

		-- Restaurer
		for k, v in pairs(zen_mode.original) do
			vim.o[k] = v
		end

		vim.notify = original_notify

		require("gitsigns").toggle_signs()

		zen_mode.active = false

		require("marks").toggle_signs()

		vim.diagnostic.show()
	end
end

return M
