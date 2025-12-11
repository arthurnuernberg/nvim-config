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
    attach_mappings = function(prompt_bufnr, map)
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
    end
  })
end

return M
