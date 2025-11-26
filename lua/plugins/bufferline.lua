return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
      options = {
        mode = "buffers",
    },
    highlights = {
      buffer_selected = { italic = false, bold = false },
      tab_selected     = { italic = false, bold = false },
      tab              = { italic = false, bold = false },
      buffer_visible   = { italic = false, bold = false },
    },
  },
}
