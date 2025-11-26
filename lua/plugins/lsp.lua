return {
	"hrsh7th/cmp-nvim-lsp",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/lazydev.nvim", opts = {} },
	},
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local capabilities = cmp_nvim_lsp.default_capabilities()

		vim.lsp.config.clangd = {
			cmd = { "clangd", "--background-index" },
			capabilities = capabilities,
			filetypes = { "c", "cpp", "objc", "objcpp" },
		}

    vim.lsp.enable("clangd")
	end,
}
