return {
	"nvim-lualine/lualine.nvim",
	priority = 1000,
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		devicons = require("nvim-web-devicons")
		lualine.setup({
			options = {
				theme = "onedark",
				component_separators = "",
				section_separators = " ",
			},
			sections = {
				lualine_a = {
					" ",
					{ "mode", icon = "" },
				},
				lualine_b = { "branch", "diff" },
				lualine_c = {
					{ "filetype", icon_only = true },
					{
						"filename",
						path = 1,
						symbols = {
							modified = " ",
							readonly = " ",
							unnamed = "[No Name]",
						},
					},
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
		})
	end,
}
