---Configure file formatting
-- Use LSP formatting by default
-----------------------------------------------------------------------
if vim.g.__format_plugin__ then
	return
end
vim.g.__format_plugin__ = true

-- FIXME: Preserve marks
local function format()
	vim.lsp.buf.format({ sync = true })
end

vim.api.nvim_create_user_command("Format", format, {})

local _f = require("clue")("n", "<leader>f", "format")
vim.keymap.set("n", _f.m, format, { desc = "format current file" })
