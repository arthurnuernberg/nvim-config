local funcs = require("functions")
-- Configuration d'un autocmd pour les fichiers C et C++
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "cpp", "c" },
--   callback = function()
--     vim.opt_local.tabstop = 4
--     vim.opt_local.shiftwidth = 4
--     vim.opt_local.softtabstop = 4
--     vim.opt_local.expandtab = false
--   end,
-- })

-- Actualiser la tabline en fonction du buffer actif
vim.api.nvim_create_autocmd(
  {"BufEnter", "BufUnload"},
  { callback = funcs.update_tabline }
)

-- Define an autocommand group to avoid duplicates
vim.api.nvim_create_augroup("CustomFiletypeWrite", { clear = true })

-- Markdown buffer write
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("MarkdownToPDF", { clear = true }),
  pattern = "*.md",
  callback = funcs.compile_markdown_to_pdf,
  desc = "Compile Markdown to PDF with Pandoc on save",
})

-- Asciidoc buffer write
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("AsciidocToPDF", { clear = true }),
  pattern = { "*.adoc", "*.asciidoc", "*.asc" },
  callback = funcs.compile_asciidoc_to_pdf,
  desc = "Compile AsciiDoc to PDF with asciidoctor-pdf on save",
})
