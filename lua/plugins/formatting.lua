return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				cpp = { "clang-format" },
				c = { "clang-format" },
				go = { "gofumpt", "goimports" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "black", "isort" },
				rust = { "rustfmt" },
				tex = { "latexindent" },
				bash = { "shfmt" },
				sh = { "shfmt" },
				zsh = { "shfmt" },
			},
			formatters = {
				black = {
					command = "/Users/arthurnurnberg/.local/share/nvim/mason/bin/black",
					prepend_args = { "--line-length", "88" },
				},
				isort = {
					command = "/Users/arthurnurnberg/.local/share/nvim/mason/bin/isort",
				},
				gofumpt = {
					command = "/usr/local/bin/gofmt",
				},
				goimports = {
					command = "/usr/local/bin/goimports",
				},
				stylua = {
					command = "/Users/arthurnurnberg/.local/share/nvim/mason/bin/stylua",
					prepend_args = { "--indent-width", "2" },
				},
				rustfmt = {
					command = "/Users/arthurnurnberg/.cargo/bin/rustfmt",
				},
				latexindent = {
					command = "/usr/local/texlive/2025/bin/universal-darwin/latexindent",
				},
				shellharden = {
					command = "/Users/arthurnurnberg/.local/share/nvim/mason/bin/shfmt",
				},
			},
		})
	end,
}
