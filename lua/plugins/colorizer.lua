return {
  "norcalli/nvim-colorizer.lua",
  ft = { "html", "css", "conf" },
  config = function()
    require 'colorizer'.setup({
      "css",
      "scss",
      "html",
      "conf"
    })
  end,
}
