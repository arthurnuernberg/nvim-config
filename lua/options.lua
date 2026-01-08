local opt = vim.opt

-- Zeilennummern einblenden
opt.number = true
-- Zeilennummern relativ einblenden
opt.relativenumber = true
-- Minimale Anzahl an Zeilen über und unter dem Cursor
opt.scrolloff = 5
-- Aktuelle Zeilennummer wird markiert
opt.cursorline = true
opt.cursorlineopt = "number"
-- Länge von Tab
opt.shiftwidth = 2
-- Tab besteht aus Leerzeichen
opt.expandtab = true
-- Anzahl an Leerzeichen für Tab
opt.tabstop = 2
opt.softtabstop = 2
-- Unterstützung von .editorconfig Dateien
vim.g.editorconfig = true
-- Bestätigung bei bestimmten ungespeicherten Buffern einschalten
opt.confirm = true
-- Inline-Vorschaufenster der Ersetzung
opt.inccommand = "split"
-- Maus-Modus, z. B. für das Anpassen der Fenstergröße
opt.mouse = "a"
-- Wrap von Zeilen deaktivieren
opt.wrap = false
-- Swapfile ausstellen, nervt
opt.swapfile = false
-- Undo-File für mehr Undo-Möglichkeiten
opt.undofile = true
-- Timeout für Kombinations-Shortcuts senken
opt.timeoutlen = 600
-- Highlighting der Suchergebnisse noch nach Suche deaktivieren
opt.hlsearch = true
-- Inkrementelle Suche von Ergebnissen; Zwischenergebnisse werden angezeigt
opt.incsearch = true
-- standardmäßig case-insensitive suchen
opt.ignorecase = true
-- nur case-sensitive suchen, wenn in der Suche Großbuchstaben enthalten sind
opt.smartcase = true
-- Erweiterte Farbunterstützung
opt.termguicolors = true
-- Platz neben Zeilennummern dynamisch lassen, mindenstens 1, maximal 5 Spalten
opt.signcolumn = "auto:1-5"
-- Schnelle Update-Zeiten
opt.updatetime = 50
-- System- und Vim-Register trennen
opt.clipboard = ""
-- Session-Optionen
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- zeigt leere Zeichen an
opt.list = false
opt.listchars = {
	tab = "->",
	space = " ",
	multispace = " ",
	trail = "",
	extends = "⟩",
	precedes = "⟨",
}
vim.g.showbreak = "↪"

vim.diagnostic.config({
	float = { border = "rounded" }, -- add border to diagnostic popups
})

-- opt.formatoptions = 'l'
-- opt.formatoptions = opt.formatoptions
-- - 'a' -- Auto formatting is BAD.
-- - 't' -- Don't auto format my code. I got linters for that.
-- + 'c' -- In general, I like it when comments respect textwidth
-- - 'o' -- O and o, don't continue comments
-- + 'r' -- But do continue when pressing enter.
-- + 'n' -- Indent past the formatlistpat, not underneath it.
-- + 'j' -- Auto-remove comments if possible.
-- - '2' -- I'm not in gradeschool anymore

-- Interessante Optionen
-- opt.shortmess
-- opt.sessionoptions
-- opt.scrolljump

-- Gute Vim-Farbthemen
-- habamax
-- lunaperche, slate

-- Syntax Highlighting von Vim ausschalten, übernimmt Treesitter
vim.g.syntax = "off"
-- Leader-Key von Mappings
vim.g.mapleader = " "
