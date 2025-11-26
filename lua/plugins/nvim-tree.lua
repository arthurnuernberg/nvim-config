return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeClose", "NvimTreeCollapse", "NvimTreeFocus" },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		require("nvim-tree").setup({
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 35,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = true,
			},
		})
	end,
}
