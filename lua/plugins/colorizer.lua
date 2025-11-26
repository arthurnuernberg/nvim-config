return {
  "norcalli/nvim-colorizer.lua",
  ft = { "html", "css" },
  config = function()
    require 'colorizer'.setup({
      "css",
      "scss",
      "html",
    })
  end,
}
