local u = require("scout.utils")

local M = {}

local function display_options()
	local width = vim.o.columns * 2 / 3
	width = width < 1 and 1 or width
	local height = vim.o.lines * 1 / 3
	height = height < 1 and 1 or height
	local row = (vim.o.lines - height) / 2
	local col = (vim.o.columns - width) / 2

	local options = {
		relative = "editor",
		style = "minimal",
		width = math.floor(width),
		height = math.floor(height),
		row = row,
		col = col,
	}

	return options
end

local function title_options(main_options)
	return {
		relative = "editor",
		style = "minimal",
		width = main_options.width,
		height = 1,
		row = main_options.row + main_options.height,
		col = main_options.col,
	}
end

function M.open(label)
	local display_opts = display_options()
	local title_opts = title_options(display_opts)

	local title = {}
	title.buffer = vim.api.nvim_create_buf(false, true)
	title.id = vim.api.nvim_open_win(title.buffer, false, title_opts)

	local display = {}
	display.buffer = vim.api.nvim_create_buf(false, true)
	display.id = vim.api.nvim_open_win(display.buffer, true, display_opts)

	local signcolumn = "yes:1"

	vim.api.nvim_win_set_option(title.id, "winhl", "Normal:StatusLine,SignColumn:StatusLine")
	vim.api.nvim_win_set_option(title.id, "signcolumn", signcolumn)
	vim.api.nvim_win_set_option(display.id, "winhl", "Normal:Pmenu,SignColumn:Pmenu")
	vim.api.nvim_win_set_option(display.id, "signcolumn", signcolumn)

	local banner = "scout"
	if u.is_present(label) then
		banner = string.format("scout > %s", label)
	end
	vim.api.nvim_buf_set_lines(title.buffer, 0, -1, 0, { banner })

	return {
		title = title,
		display = display,
		close = function()
			vim.api.nvim_win_close(title.id, true)
			vim.api.nvim_buf_delete(title.buffer, { force = true })
			vim.api.nvim_win_close(display.id, true)
			vim.api.nvim_buf_delete(display.buffer, { force = true })
		end,
	}
end

return M
