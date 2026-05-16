-- ~/.config/nvim/lua/plugins/treesitter.lua

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
        },
        indent = {
          enable = true,
        },
      })
    end,
  },
}