-- ~/.config/nvim/lua/plugins/ai.lua
return {
  {
    "johnseth97/codex.nvim",
    cmd = { "Codex", "CodexToggle" },
    keys = {
      {
        "<leader>aa",
        function()
          require("codex").toggle()
        end,
        desc = "Toggle Codex",
        mode = { "n", "t" },
      },
    },
    opts = {
      keymaps = {
        toggle = nil,
        quit = "<C-q>",
      },
      border = "rounded",
      width = 0.8,
      height = 0.8,
      model = nil,
      autoinstall = true,
      panel = false,
      use_buffer = false,
    },
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatClose",
      "CopilotChatToggle",
      "CopilotChatStop",
      "CopilotChatReset",
      "CopilotChatSave",
      "CopilotChatLoad",
      "CopilotChatPrompts",
      "CopilotChatModels",
    },
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {},
    keys = {
      {
        "<leader>ac",
        "<cmd>CopilotChatToggle<cr>",
        mode = { "n", "v" },
        desc = "CopilotChat toggle",
      },
      {
        "<leader>ae",
        "<cmd>CopilotChatExplain<cr>",
        mode = "v",
        desc = "CopilotChat explain selection",
      },
      {
        "<leader>af",
        "<cmd>CopilotChatFix<cr>",
        mode = "v",
        desc = "CopilotChat fix selection",
      },
    },
  },
}
