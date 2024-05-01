return {
  "tpope/vim-surround", -- Surround stuff with the ys-, cs-, ds- commands; 快速修改包围符号
    -- "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically;
  -- {{{
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    }
  },
  {
    "numToStr/Comment.nvim",
    config = function()
     return require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    end
  },
  -- }}}
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      mappings = {
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\`].", register = { cr = false } },
      },
    },
    keys = {
      {
        "<leader>up",
        function()
          vim.g.minipairs_disable = not vim.g.minipairs_disable
        end,
        desc = "Toggle Auto Pairs",
      },
    },
  }
}
