-- example: https://git.hubrecht.ovh/hubrecht/NeoVim-config/src/commit/90bd51d809550c828aeafc1da78e4e636991e465/lua/user/toggleterm.lua
return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {},
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
      })
    end
  }
}
