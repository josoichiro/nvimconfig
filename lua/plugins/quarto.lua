-- ~/.config/nvim/lua/plugins/quarto.lua

return {
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      debug = false,
      closePreviewOnExit = true,
      lspFeatures = {
        enabled = true,
        chunks = "curly",
        languages = {
          "python",
          "julia",
          "bash",
          "html",
        },
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      codeRunner = {
        enabled = false,
      },
    },
    keys = {
      {
        "<leader>qp",
        function()
          require("quarto").quartoPreview()
        end,
        desc = "Quarto preview",
      },
      {
        "<leader>qc",
        function()
          require("quarto").quartoClosePreview()
        end,
        desc = "Close Quarto preview",
      },
    },
  },
}