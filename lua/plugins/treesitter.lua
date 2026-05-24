-- ~/.config/nvim/lua/plugins/treesitter.lua

local parsers = {
  "lua",
  "vim",
  "vimdoc",
  "bash",
  "python",
  "julia",
  "c",
  "cpp",
  "fortran",
  "html",
  "css",
  "json",
  "markdown",
  "markdown_inline",
  "yaml",
}

-- vim.treesitter.start() を実行する FileType。
-- parser 名と filetype 名が違うものがあるので、parsers とは分ける。
local start_filetypes = {
  "lua",
  "vim",
  "vimdoc",
  "help",
  "bash",
  "sh",
  "python",
  "julia",
  "c",
  "cpp",
  "fortran",
  "html",
  "css",
  "json",
  "markdown",
  "yaml",
}

-- Codex / CopilotChat などの対話バッファでは Treesitter を起動しない。
local treesitter_disabled_filetypes = {
  codex = true,
  ["copilot-chat"] = true,
  CopilotChat = true,
}

-- 旧設定と同じく、markdown / yaml は Treesitter indent を使わない。
local indent_disabled_filetypes = {
  markdown = true,
  yaml = true,
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      ts.setup({
        -- デフォルトでも stdpath("data") .. "/site" だが、明示しておく
        -- ことで main ブランチの想定設定に寄せる。
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- parser 名と Neovim の filetype 名が違うものを明示的に対応づける。
      vim.treesitter.language.register("vimdoc", { "help", "vimdoc" })
      vim.treesitter.language.register("bash", { "sh", "bash" })

      -- 旧 ensure_installed 相当。
      -- 既に入っている parser については no-op。
      ts.install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user-treesitter-main", { clear = true }),
        pattern = start_filetypes,
        callback = function(args)
          local buf = args.buf
          local ft = vim.bo[buf].filetype
          local bt = vim.bo[buf].buftype

          if treesitter_disabled_filetypes[ft] then
            return
          end

          -- CopilotChat などが markdown filetype の nofile バッファを作る場合の保険。
          -- 通常ファイルの markdown は対象外。
          if bt == "nofile" and ft == "markdown" then
            return
          end

          local ok = pcall(vim.treesitter.start, buf)
          if not ok then
            return
          end

          if not indent_disabled_filetypes[ft] then
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
