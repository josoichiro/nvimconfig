# nvimconfig

Personal Neovim configuration managed with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Features

- Lazy-loaded plugin management
- LSP support with Mason + mason-lspconfig + nvim-lspconfig
- Completion with `blink.cmp`
- Syntax highlighting and indentation via Treesitter
- File explorer with Neo-tree
- Fuzzy finder with Telescope
- Buffer/tabline UI with barbar.nvim
- Statusline with lualine
- Git signs with gitsigns
- Integrated terminal with toggleterm
- Format on save with conform.nvim

## Requirements

- Neovim 0.9+
- `git`
- A Nerd Font (for icons)

Optional tools used by this config:

- LSP servers installed via `:Mason` (auto-installs `lua_ls`)
- Formatters such as `stylua`, `black`, `isort`, `prettier`/`prettierd`
- WezTerm CLI (`wezterm cli` / `wezterm imgcat`) for image preview helper in Neo-tree

## Installation

1. Backup your current Neovim config if needed.
2. Clone this repository to your Neovim config directory:

```bash
git clone https://github.com/josoichiro/nvimconfig ~/.config/nvim
```

3. Start Neovim:

```bash
nvim
```

`lazy.nvim` will be bootstrapped automatically and plugins will be installed.

## Structure

- `init.lua`: entry point
- `lua/config/`: core options, keymaps, autocmds, diagnostics, lazy setup
- `lua/plugins/`: plugin specs
- `lua/utils/`: utility helpers (`image-preview.lua`)

## Key mappings

Leader key is `<Space>`.

### Buffers (barbar.nvim)

- `<S-h>` / `<S-l>`: previous/next buffer
- `<leader>bd`: close buffer
- `<leader>bp`: pin buffer
- `<leader>bb`: pick buffer
- `<leader>bD`: close other buffers
- `<A-,>` / `<A-.>`: move buffer left/right

### Windows / splits

- `<leader>sv`: vertical split
- `<leader>sh`: horizontal split
- `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>`: move between windows

### Explorer / search

- `<leader>e`: toggle Neo-tree
- `<leader>E`: reveal current file in Neo-tree
- `<leader>ff`: find files (Telescope)
- `<leader>fg`: live grep (Telescope)
- `<leader>fb`: buffers (Telescope)
- `<leader>fh`: help tags (Telescope)

### Formatting / terminal

- `<leader>f`: format current buffer
- `<leader>tt`: toggle horizontal terminal
- `<leader>tf`: toggle floating terminal
- `<leader>tv`: toggle vertical terminal
- `<C-\\>`: toggle terminal (toggleterm open mapping)

### LSP (on attach)

- `gd`: go to definition
- `gr`: references
- `K`: hover
- `<leader>rn`: rename symbol
- `<leader>ca`: code action

## Notes

- Opening Neovim with a directory argument opens Neo-tree on startup.
- `lua/plugins/quarto.lua` exists but is not currently imported in `lua/config/lazy.lua`.
