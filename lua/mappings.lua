local map = vim.keymap.set

local funcs = require("functions")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local standard_opts = { silent = true, noremap = true }
local opts_with_description = { silent = true, noremap = true, desc = "" }

map("n", "<C-c>", "<cmd>noh<CR>", standard_opts)
map("v", "<C-c>", "<Esc>", standard_opts)
map("n", "Q", "<nop>", standard_opts)

opts_with_description.desc = "Scroll up"
map("n", "<C-u>", "<C-u>zz", opts_with_description) -- Beim hochscrollen bleibt Cursor in der Mitte

opts_with_description.desc = "Close all windows"
map("n", "ZA", "<cmd>qa<cr>", opts_with_description) -- Alle Buffer schließen

opts_with_description.desc = "Force close all windows"
map("n", "ZF", "<cmd>qa!<cr>", opts_with_description) -- Alle Buffer erzwungen schließen

opts_with_description.desc = "Force close and save all windows"
map("n", "ZS", "<cmd>wqa<cr>", opts_with_description) -- Alle Buffer erzwungen schließen und speichern

opts_with_description.desc = "Scroll down and center cursor"
map("n", "<C-d>", "<C-d>zz", opts_with_description) -- Beim runterscrollen bleibt Cursor in der Mitte

opts_with_description.desc = "Search forward"
map("n", "n", "nzz", opts_with_description) -- Suchergebnisse in der Mitte bei der Vorwärtssuche
map("n", "N", "Nzz", opts_with_description) -- Suchergebnisse in der Mitte bei der Rückwärtssuche

opts_with_description.desc = "Close current buffer"
map("n", "<leader>bd", ":bd<CR>", opts_with_description)

opts_with_description.desc = "Go to next buffer"
map("n", "<leader>bn", "<cmd>bn<CR>", opts_with_description)

opts_with_description.desc = "Go to previous buffer"
map("n", "<leader>bp", "<cmd>bp<CR>", opts_with_description)

opts_with_description.desc = "List open buffers"
map("n", "<leader>bl", "<cmd>buffers<CR>", opts_with_description)

opts_with_description.desc = "Open a new buffer"
map("n", "<leader>bo", "<cmd>enew<CR>", opts_with_description)

opts_with_description.desc = "Copy entire file content"
map({ "n", "v" }, "yA", "mygoyG`y", opts_with_description) -- Gesamten Dateinhalt kopieren
map({ "n", "v" }, "<leader>Y", 'mygo"+yG`y', opts_with_description) -- Gesamten Dateinhalt in Systemablage kopieren

opts_with_description.desc = "Copy into system clipboard"
map({ "n", "v" }, "<leader>y", '"+y', opts_with_description) -- Kopieren in die Systemablage mit y in Visual und Normal-Modus
-- map({ "n", "v" }, "<leader>Y", '"+Y', opts_with_description) -- Kopieren in die Systemablage mit Y in Visual und Normal-Modus
map({ "n", "v" }, "<leader>p", '"+p', opts_with_description) -- Einfügen aus der Systemablage mit p in Visual und Normal-Modus
map({ "n", "v" }, "<leader>P", '"+P', opts_with_description) -- Einfügen aus der Systemablage mit P in Visual und Normal-Modus
map("n", "J", "mzJ`z", { desc = "Join line below" }) -- Bei Line Joins bleibt der Cursor stehen
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" }) -- hochbewegen von Zeilen im Visual-Modus
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move line down" }) -- runterbewegen von Zeilen im Visual-Modus

opts_with_description.desc = "Cut into system clipboard"
-- map({ "n", "v" }, "<leader>d", '"+d', opts_with_description) -- Ausschneiden in die Systemablage mit d in Visual und Normal-Modus
-- map({ "n", "v" }, "<leader>D", '"+D', opts_with_description) -- Ausschneiden in die Systemablage mit D in Visual und Normal-Modus

opts_with_description.desc = "Paste contents"
map("v", "p", '"_dP', opts_with_description) -- Überschreiben von anderem Inhalt behält die Zwischenablage

-- Key Mappings für VimTeX-Funktionen
vim.api.nvim_set_keymap(
	"n",
	"<leader>li",
	"<cmd>VimtexInfo<CR>",
	{ silent = true, noremap = true, desc = "Show VimTeX Info" }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>lI",
	"<cmd>VimtexInfoFull<CR>",
	{ silent = true, noremap = true, desc = "Show VimTeX Full Info" }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>lt",
	"<cmd>VimtexTOCOpen<CR>",
	{ silent = true, noremap = true, desc = "Open Table of Contents" }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>ls",
	"<cmd>VimtexStatus<CR>",
	{ silent = true, noremap = true, desc = "Show VimTeX Status" }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>lc",
	"<cmd>VimtexCompile<CR>",
	{ silent = true, noremap = true, desc = "Compile LaTeX document" }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>lv",
	"<cmd>VimtexView<CR>",
	{ silent = true, noremap = true, desc = "View compiled PDF" }
)

map("n", "<leader>wr", "<cmd>AutoSession restore<CR>", { desc = "Restore session for cwd" }) -- Letzte Session in diesem Pfad wiederherstellen
map("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session for auto session root dir" }) -- Session in diesem Pfad speichern

opts_with_description.desc = "Center cursor horizontally"
map({ "n", "v" }, "<leader>z", funcs.center_cursor_horizontally, opts_with_description)

opts_with_description.desc = "Show File Explorer"
map({ "n", "v" }, "<C-n>", "<cmd>NvimTreeToggle<CR>", opts_with_description) -- NvimTree Datei-Explorer togglen

opts_with_description.desc = "Format file with LSP or Conform"
local _, conform = pcall(require, "conform")
vim.keymap.set({ "n", "v" }, "<leader>=", function()
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 1000,
	})
end, opts_with_description)
opts_with_description.desc = "Format file with Vim"
vim.keymap.set({ "n", "v" }, "<leader>+", function()
	funcs.format_file()
end, opts_with_description)

-- Fugitive Mappings
opts_with_description.desc = "Git diff of current file"
map({ "n", "v" }, "<C-g>", function()
	if funcs.fugitive_diff_is_open() then
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
end, opts_with_description)

map("n", "<C-l>", funcs.toggle_gblame, opts_with_description)

-- Telescope Mappings
map(
	"n",
	"<leader>ff",
	"<cmd>Telescope find_files<cr>",
	{ silent = true, noremap = true, desc = "Fuzzy find files in cwd" }
)

-- map( "n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { silent = true, noremap = true, desc = "Fuzzy find recent files" })
map("n", "<leader>fr", function()
	require("telescope.builtin").oldfiles({ results = 300 })
end, {
	silent = true,
	noremap = true,
	desc = "Fuzzy find recent files",
})

map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { silent = true, noremap = true, desc = "Find string in cwd" })
map(
	"n",
	"<leader>fc",
	"<cmd>Telescope grep_string<cr>",
	{ silent = true, noremap = true, desc = "Find string under cursor in cwd" }
)
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { silent = true, noremap = true, desc = "Find todos" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { silent = true, noremap = true, desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { silent = true, noremap = true, desc = "Search in help" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { silent = true, noremap = true, desc = "Show Keymaps" })
map(
	"n",
	"<leader>fi",
	"<cmd>Telescope command_history<cr>",
	{ silent = true, noremap = true, desc = "Show command history" }
)

-- map(
-- 	"n",
-- 	"<leader>fe",
-- 	"<cmd>lua require('telescope.builtin').find_files({ search_dirs = {vim.env.HOME, '/Applications'}, hidden = true })<cr>",
-- 	{
-- 		silent = true,
-- 		noremap = true,
-- 		desc = "Find files everywhere",
-- 	}
-- )

-- F5 : Debugging starten/fortfahren
map("n", "<F5>", function()
	require("dap").continue()
end, { silent = true, noremap = true, desc = "DAP Continue/Start" })

-- F7 : Beenden
map("n", "<F7>", function()
	require("dap").close()
end, { silent = true, noremap = true, desc = "DAP Close Session" })

-- F10 : step over
map("n", "<F10>", function()
	require("dap").step_over()
end, { silent = true, noremap = true, desc = "DAP Step Over" })

-- F6 : step into
map("n", "<F6>", function()
	require("dap").step_into()
end, { silent = true, noremap = true, desc = "DAP Step Into" })

-- F12 : step out
map("n", "<F12>", function()
	require("dap").step_out()
end, { silent = true, noremap = true, desc = "DAP Step Out" })

-- <leader>db : Abbruchpunkt
map("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { silent = true, noremap = true, desc = "DAP Toggle Breakpoint" })

-- <leader>dB : konditioneller Abbruchpunkt
map("n", "<leader>dB", function()
	local cond = vim.fn.input("Breakpoint condition: ")
	if cond ~= "" then
		require("dap").set_breakpoint(cond)
	end
end, { silent = true, noremap = true, desc = "DAP Conditional Breakpoint" })

-- <leader>dr : REPL DAP starten (Direkte Konsole)
map("n", "<leader>dr", function()
	require("dap").repl.open()
end, { silent = true, noremap = true, desc = "DAP Live Console" })

-- <leader>dl : Letzte Konfiguration erneut starten
map("n", "<leader>dl", function()
	require("dap").run_last()
end, { silent = true, noremap = true, desc = "DAP Run Last Config" })

-- <leader>du : UI DAP ein/ausschalten
map("n", "<leader>du", function()
	require("dapui").toggle()
end, { silent = true, noremap = true, desc = "DAP UI Toggle" })
