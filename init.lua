require("config.lazy")
require("options")
require("mappings")
require("autocmds")
local funcs = require("functions")
funcs.load_last_theme()
funcs.update_tabline()
vim.o.background = 'dark'
