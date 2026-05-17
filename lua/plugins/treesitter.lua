-- ~/.config/nvim/lua/plugins/treesitter.lua

local ai_chat_filetypes = {
  "codecompanion",
  "Avante",
  "copilot-chat",
  "CopilotChat",
  "chatgpt",
  "neoai",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
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
        },

        highlight = {
          enable = true,

          -- AI chat 系バッファでは Treesitter highlight を無効化する
          -- 今回の languagetree.lua / highlighter.lua エラー回避用
          disable = function(lang, buf)
            local ft = vim.bo[buf].filetype
            local bt = vim.bo[buf].buftype

            if vim.tbl_contains(ai_chat_filetypes, ft) then
              return true
            end

            -- AI chat プラグインによっては ft=markdown の nofile バッファになることがある
            if bt == "nofile" and (lang == "markdown" or lang == "markdown_inline") then
              return true
            end

            return false
          end,

          additional_vim_regex_highlighting = false,
        },

        indent = {
          enable = true,

          -- markdown / yaml は Treesitter indent が荒れやすいので無効化推奨
          disable = {
            "markdown",
            "markdown_inline",
            "yaml",
          },
        },
      })
    end,
  },
}
