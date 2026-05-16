-- ~/.config/nvim/lua/config/options.lua

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.fillchars = {
  eob = " ",
  vert = "│",
}