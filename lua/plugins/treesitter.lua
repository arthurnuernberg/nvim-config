return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"vim",
				"vimdoc",
				"javascript",
				"typescript",
				"tsx",
				"python",
				"rust",
				"go",
				"c",
        "csv",
				"cpp",
				"html",
				"css",
				"json",
				"yaml",
				"markdown",
				"markdown_inline",
				"bash",
			},

			sync_install = false,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			indent = {
				enable = true,
			},
		})
	end,
}
