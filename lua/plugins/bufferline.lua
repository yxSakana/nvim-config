return {
  {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {},
    config = function()
      require("bufferline").setup({
        options = {
          buffer_close_icon = 'x',
          indicator = {
            icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = 'icon',
          },
          hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close' }
          },
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left"
            }
          }
        }
      })
    end,
  }
}
