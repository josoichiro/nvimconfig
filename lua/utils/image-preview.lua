-- ~/.config/nvim/lua/utils/image_preview.lua

local M = {}

local image_exts = {
  png = true,
  jpg = true,
  jpeg = true,
  gif = true,
  webp = true,
  bmp = true,
  svg = true,
}

function M.preview_in_wezterm(path)
  path = vim.fn.fnamemodify(path, ":p")

  local ext = path:match("^.+%.(.+)$")
  if not ext or not image_exts[ext:lower()] then
    vim.notify("Not an image file: " .. path, vim.log.levels.WARN)
    return
  end

  local pane_id = vim.fn.system({
    "wezterm",
    "cli",
    "split-pane",
    "--right",
    "--percent",
    "40",
  })

  pane_id = vim.trim(pane_id)

  if vim.v.shell_error ~= 0 or pane_id == "" then
    vim.notify("Failed to create WezTerm pane", vim.log.levels.ERROR)
    return
  end

  local command = table.concat({
    "clear",
    "wezterm imgcat --width 100% " .. vim.fn.shellescape(path),
    "echo",
    "echo 'Press Enter to close...'",
    "read",
    "exit",
    "",
  }, "\n")

  vim.fn.jobstart({
    "wezterm",
    "cli",
    "send-text",
    "--no-paste",
    "--pane-id",
    pane_id,
    command,
  }, {
    detach = true,
  })
end

return M