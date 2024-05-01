return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = false,
        popup_border_style = "rounded",
      })
      require("helpers.maps").map(
        { "n", "v" },
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toogle = true, dir = vim.uv.cwd() })
        end,
        "Toggle file explorer"
      )
    end,
  }
}
