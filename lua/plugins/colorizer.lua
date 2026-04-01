return {
  "norcalli/nvim-colorizer.lua",
  ft = { "html", "css", "conf", "python" },
  config = function()
    require 'colorizer'.setup({
      '*';
    })
  end,
}
