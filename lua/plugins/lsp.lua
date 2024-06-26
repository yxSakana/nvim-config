return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim", -- manage lsp service user interface
      "williamboman/mason-lspconfig.nvim",
      {
        "j-hui/fidget.nvim", -- Extensible UI for Neovim notifications and LSP progress messages.
        tag = "legacy",
        event = "LspAttach",
      },
      "folke/neodev.nvim",     -- for neovim devlop
      "RRethy/vim-illuminate", -- highlighting
      "hrsh7th/cmp-nvim-lsp",  -- cmp
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pylsp",
          "clangd",
          "cmake",
          "dockerls",
          "docker_compose_language_service",
        },
        automatic_installation = false
      })
      require("helpers.maps").map("n", "<leader>M", "<cmd>Mason<cr>", "Show Mason")
      require("neodev").setup()
      require("fidget").setup()

      -- Set up cool signs
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- Diagnostic config
      local config = {
        virtual_text = false,
        signs = {
          active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      }
      vim.diagnostic.config(config)

      local on_attach = function(client, bufnr)
        local lsp_map = require("helpers.maps").lsp_map

        lsp_map("<leader>lr", vim.lsp.buf.rename, bufnr, "Rename symbol")
        lsp_map("<leader>la", vim.lsp.buf.code_action, bufnr, "Code action")
        lsp_map("<leader>ld", vim.lsp.buf.type_definition, bufnr, "Type definition")
        lsp_map("<leader>ls", require("telescope.builtin").lsp_document_symbols, bufnr, "Document symbols")

        lsp_map("gd", vim.lsp.buf.definition, bufnr, "Goto Definition")
        lsp_map("gr", require("telescope.builtin").lsp_references, bufnr, "Goto References")
        lsp_map("gI", vim.lsp.buf.implementation, bufnr, "Goto Implementation")
        lsp_map("K", vim.lsp.buf.hover, bufnr, "Hover Documentation")
        lsp_map("gD", vim.lsp.buf.declaration, bufnr, "Goto Declaration")

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
          vim.lsp.buf.format()
        end, { desc = "Format current buffer with LSP" })

        lsp_map("<leader>ff", "<cmd>Format<cr>", bufnr, "Format")

        -- Attach and configure vim-illuminate
        require("illuminate").on_attach(client)
      end

      -- nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      -- Lua
      require("lspconfig")["lua_ls"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        }
      })

      -- C/C++
      require("lspconfig").clangd.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "h", "c", "cpp", "cc", "hpp" },
        keys = { { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Swith Source/Header (C/C++)" } },
        root_dir = require("lspconfig").util.root_pattern(
          '.clangd',
          '.clang-tidy',
          '.clang-format',
          'compile_commands.json',
          'compile_flags.txt',
          'configure.ac',
          '.git'
        )
      })

      -- CMake
      require("lspconfig").cmake.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "cmake" },
        init_options = {
          buildDirectory = "build"
        },
        root_dir = require("lspconfig").util.root_pattern(
          "CMakePresets.json",
          "CTestConfig.cmake",
          ".git",
          "build",
          "cmake"
        ),
        single_file_support = true,
      })

      -- Python
      require("lspconfig").pylsp.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "python" },
        settings = {
          pylsp = {
            plugins = {
              flake8 = {
                enabled = true,
                maxLineLength = 88, -- Black's line length
              },
              -- Disable plugins overlapping with flake8
              pycodestyle = {
                enabled = false,
              },
              mccabe = {
                enabled = false,
              },
              pyflakes = {
                enabled = false,
              },
              -- Use Black as the formatter
              autopep8 = {
                enabled = false,
              },
            },
          },
        },
      })

      -- Docker
      require("lspconfig").dockerls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "docker-langserver", "--stdio" },
        filetypes = { "dockerfile" },
        root_dir = require("lspconfig").util.root_pattern(
          "Dockerfile"
        ),
        single_file_support = true,
      })
      require("lspconfig").docker_compose_language_service.setup({})
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "cpplint",
        "cmakelang",
        "cmakelint",
        "clang-format",
        "cpptools",
        "codelldb",
        "flake8",
        "hadolint"
      }
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end
  }
}
