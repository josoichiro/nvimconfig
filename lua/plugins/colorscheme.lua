-- ~/.config/nvim/lua/plugins/colorscheme.lua

return {
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = false,
          terminal_colors = true,
        },
      })

      vim.cmd.colorscheme("nordfox")
    end,
  },
}