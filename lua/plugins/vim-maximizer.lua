return {
  "szw/vim-maximizer",
  keys = {
    { "<leader>sm", function() vim.cmd("MaximizerToggle") end, desc = "Maximize/minimize a split" },
  },
}
