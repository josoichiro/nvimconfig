-- ~/.config/nvim/lua/config/local_lsp.lua
-- Remote-server-only settings. Do not commit.

local julia = vim.fn.expand("~/work/opt/juliaup/bin/julia")
local ls_env = vim.fn.expand("~/.julia/environments/nvim-lspconfig")

if vim.fn.executable(julia) ~= 1 then
  vim.notify("Remote Julia executable not found: " .. julia, vim.log.levels.WARN)
  return
end

vim.lsp.config("julials", {
  cmd = {
    julia,
    "--project=" .. ls_env,
    "--startup-file=no",
    "--history-file=no",
    "-e",
    [[
      using LanguageServer
      runserver()
    ]],
  },

  filetypes = { "julia" },

  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root = vim.fs.root(fname, {
      "Project.toml",
      "JuliaProject.toml",
      ".git",
    })

    on_dir(root or vim.fs.dirname(fname))
  end,
})

vim.lsp.enable("julials")
