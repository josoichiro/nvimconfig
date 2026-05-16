-- ~/.config/nvim/lua/config/keymaps.lua

local map = vim.keymap.set

-- barbar.nvim buffer操作
map("n", "<S-h>", "<cmd>BufferPrevious<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>BufferNext<cr>", { desc = "Next buffer" })

map("n", "<leader>bd", "<cmd>BufferClose<cr>", { desc = "Close buffer" })
map("n", "<leader>bp", "<cmd>BufferPin<cr>", { desc = "Pin buffer" })
map("n", "<leader>bb", "<cmd>BufferPick<cr>", { desc = "Pick buffer" })
map("n", "<leader>bD", "<cmd>BufferCloseAllButCurrent<cr>", { desc = "Close other buffers" })

map("n", "<A-,>", "<cmd>BufferMovePrevious<cr>", { desc = "Move buffer left" })
map("n", "<A-.>", "<cmd>BufferMoveNext<cr>", { desc = "Move buffer right" })

-- split操作
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Horizontal split" })

-- Image Preview
map("n", "<leader>ip", function()
	require("utils.image-preview").preview_in_wezterm(vim.fn.expand("%:p"))
end, { desc = "Preview image in WezTerm" })
map("n", "<leader>iP", function()
	require("utils.image-preview").close_preview_pane()
end, { desc = "Close image preview pane" })

-- window移動
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })

-- terminal mode
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Move to left window" })
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Move to right window" })
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Move to lower window" })
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Move to upper window" })
