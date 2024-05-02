return {
  {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    config = function()
      local colorscheme = require("helpers.colorscheme")
      local lualine_theme = colorscheme == "default" and "auto" or colorscheme
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = lualine_theme,
          component_separators = "|",
          section_separators = "",
          sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress', 'location' },
            -- lualine_z = { 'location' },
            lualine_z = {
              function()
                return " " .. os.date("%R")
              end,
            },
          },
        }
      })
    end,
    -- enabled = false
  },
}
