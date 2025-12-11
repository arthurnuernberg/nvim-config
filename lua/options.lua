local opt = vim.opt

-- Zeilennummern einblenden
opt.number = true
-- Zeilennummern relativ einblenden
opt.relativenumber = true
-- Minimale Anzahl an Zeilen über und unter dem Cursor
opt.scrolloff = 5
-- Länge von Tab
opt.shiftwidth = 2
-- Tab besteht aus Leerzeichen
opt.expandtab = true
-- Anzahl an Leerzeichen für Tab
opt.tabstop = 2
opt.softtabstop = 2
-- Für Ligaturen-Unterstützung (-> wird zu →)
-- vim.o.guifont = "LB Mono:h14"
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
-- Zweifach Platz neben Zeilennummern immer lassen für fixen Platz links
opt.signcolumn = "yes:2"
-- Schnelle Update-Zeiten
opt.updatetime = 50
-- System- und Vim-Register trennen
opt.clipboard = ""

-- Syntax Highlighting von Vim ausschalten, übernimmt Treesitter
vim.g.syntax = "off"
-- Leader-Key von Mappings
vim.g.mapleader = " "

-- Session-Optionen
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
