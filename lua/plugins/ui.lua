-- ~/.config/nvim/lua/plugins/ui.lua

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "nordfox",
      },
    },
  },

  {
    "romgrk/barbar.nvim",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      animation = true,
      clickable = true,
      tabpages = false,
      focus_on_close = "left",

      exclude_name = { "" },

      exclude_ft = {
        "neo-tree",
        "toggleterm",
        "TelescopePrompt",
        "lazy",
        "mason",
        "help",
        "qf",
        "terminal",
      },

      sidebar_filetypes = {
        ["neo-tree"] = {
          event = "BufWipeout",
          text = "Explorer",
          align = "left",
        },
      },

      icons = {
        button = "×",
        modified = { button = "●" },
        pinned = { button = "", filename = true },

        separator = {
          left = "▎",
          right = "",
        },

        filetype = {
          enabled = true,
        },

        gitsigns = {
          added = { enabled = true, icon = "+" },
          changed = { enabled = true, icon = "~" },
          deleted = { enabled = true, icon = "-" },
        },
      },
    },
    version = "^1.0.0",
  },
}