-- ~/.config/nvim/lua/plugins/lsp.lua

local function load_local_lsp()
  local ok, local_lsp = pcall(require, "config.local_lsp")

  if ok and type(local_lsp) == "table" then
    return local_lsp
  end

  vim.schedule(function()
    vim.notify("Failed to load config.local_lsp", vim.log.levels.WARN)
  end)

  return {
    ensure_installed = {},
    servers = {},
  }
end

local function setup_and_enable_servers(servers, capabilities)
  if vim.islist(servers) then
    for _, server in ipairs(servers) do
      vim.lsp.config(server, {
        capabilities = capabilities,
      })
      vim.lsp.enable(server)
    end
    return
  end

  for server, spec in pairs(servers or {}) do
    if spec == true then
      vim.lsp.config(server, {
        capabilities = capabilities,
      })
      vim.lsp.enable(server)
    elseif type(spec) == "table" then
      if spec.enabled ~= false then
        local config = vim.tbl_deep_extend("force", spec.config or {}, {
          capabilities = capabilities,
        })

        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
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
      local local_lsp = load_local_lsp()

      require("mason-lspconfig").setup({
        ensure_installed = local_lsp.ensure_installed or {},
        automatic_enable = false,
      })

      setup_and_enable_servers(local_lsp.servers, capabilities)

      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
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
      })
    end,
  },
}
