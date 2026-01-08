return {
  "navarasu/onedark.nvim",
  priority = 1010,
  lazy = false,
  config = function()
    local theme = require("onedark")
    theme.setup({
      style = "dark",
      term_colors = true,
      toggle_style_key = "<leader>o",
    })
    -- theme.load()
  end,
}
