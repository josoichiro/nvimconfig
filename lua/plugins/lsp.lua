-- ~/.config/nvim/lua/plugins/lsp.lua

return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },

    -- ここが重要:
    -- plugin 本体は lazy のままでも、init は起動時に実行される
    init = function()
      local ok, err = pcall(require, "config.local_lsp")
      if not ok then
        vim.schedule(function()
          vim.notify("Failed to load config.local_lsp: " .. err, vim.log.levels.ERROR)
        end)
      end
    end,
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
        clangd = {},   -- C / C++
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
          "clangd",
        },
      })
    end,
  },
}
