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

local preview_pane_id = nil

local function is_image(path)
	local ext = path:match("^.+%.(.+)$")
	return ext and image_exts[ext:lower()]
end

local function send_to_pane(pane_id, command)
	local output = vim.fn.system({
		"wezterm",
		"cli",
		"send-text",
		"--no-paste",
		"--pane-id",
		pane_id,
		command,
	})

	return vim.v.shell_error == 0, output
end

local function create_preview_pane()
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
		return nil
	end

	return pane_id
end

function M.preview_in_wezterm(path)
	path = vim.fn.fnamemodify(path, ":p")

	if not is_image(path) then
		vim.notify("Not an image file: " .. path, vim.log.levels.WARN)
		return
	end

	if not preview_pane_id then
		preview_pane_id = create_preview_pane()

		if not preview_pane_id then
			vim.notify("Failed to create WezTerm pane", vim.log.levels.ERROR)
			return
		end
	end

	local command = table.concat({
		"clear",
		"wezterm imgcat --width 100% " .. vim.fn.shellescape(path),
		"echo",
		"echo '[image preview] " .. vim.fn.fnamemodify(path, ":t") .. "'",
		"",
	}, "\n")

	local ok = send_to_pane(preview_pane_id, command)

	-- 以前作った pane が閉じられていた場合は作り直す
	if not ok then
		preview_pane_id = create_preview_pane()

		if not preview_pane_id then
			vim.notify("Failed to recreate WezTerm pane", vim.log.levels.ERROR)
			return
		end

		send_to_pane(preview_pane_id, command)
	end
end

function M.close_preview_pane()
	if not preview_pane_id then
		return
	end

	vim.fn.jobstart({
		"wezterm",
		"cli",
		"kill-pane",
		"--pane-id",
		preview_pane_id,
	}, {
		detach = true,
	})

	preview_pane_id = nil
end

return M

