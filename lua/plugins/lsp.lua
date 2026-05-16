-- ~/.config/nvim/lua/plugins/lsp.lua

return {
  {
    "neovim/nvim-lspconfig",
  },

  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp",
    },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- 設定だけ書いておく。
      -- 実際に起動するのは Mason でインストール済みのものだけ。
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                checkThirdParty = false,
              },
            },
          },
        },

        -- 必要になったら :Mason でインストールする
        fortls = {},   -- Fortran
        julials = {},  -- Julia
        clangd = {},   -- C / C++
        pyright = {},  -- Python
      }

      for server, config in pairs(servers) do
        config.capabilities = capabilities

        if vim.lsp.config then
          vim.lsp.config(server, config)
        else
          require("lspconfig")[server].setup(config)
        end
      end

      require("mason-lspconfig").setup({
        -- 自動インストールはLuaだけ
        ensure_installed = {
          "lua_ls",
        },

        -- Masonでインストール済みなら自動で有効化する候補
        automatic_enable = {
          "lua_ls",
          "fortls",
          "julials",
          "clangd",
          "pyright",
        },
      })
    end,
  },
}