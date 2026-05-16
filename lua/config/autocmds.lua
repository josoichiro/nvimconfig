-- ~/.config/nvim/lua/config/autocmds.lua

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set(
      "n",
      "gd",
      vim.lsp.buf.definition,
      vim.tbl_extend("force", opts, { desc = "Go to definition" })
    )

    vim.keymap.set(
      "n",
      "gr",
      vim.lsp.buf.references,
      vim.tbl_extend("force", opts, { desc = "References" })
    )

    vim.keymap.set(
      "n",
      "K",
      vim.lsp.buf.hover,
      vim.tbl_extend("force", opts, { desc = "Hover" })
    )

    vim.keymap.set(
      "n",
      "<leader>rn",
      vim.lsp.buf.rename,
      vim.tbl_extend("force", opts, { desc = "Rename" })
    )

    vim.keymap.set(
      "n",
      "<leader>ca",
      vim.lsp.buf.code_action,
      vim.tbl_extend("force", opts, { desc = "Code action" })
    )
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() ~= 1 then
      return
    end

    local arg = vim.fn.argv(0)

    if vim.fn.isdirectory(arg) ~= 1 then
      return
    end

    local dir = vim.fn.fnamemodify(arg, ":p")

    vim.cmd("cd " .. vim.fn.fnameescape(dir))
    vim.cmd("Neotree left dir=" .. vim.fn.fnameescape(dir))
    vim.cmd("wincmd l")

    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted then
        local name = vim.api.nvim_buf_get_name(bufnr)
        local is_empty = name == ""
        local is_dir = name ~= "" and vim.fn.isdirectory(name) == 1

        if (is_empty or is_dir) and not vim.bo[bufnr].modified then
          vim.bo[bufnr].buflisted = false
        end
      end
    end
  end,
})