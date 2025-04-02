---Configure toggleterm plugin: https://github.com/akinsho/toggleterm.nvim
-- A neovim lua plugin to help easily manage multiple terminal windows
-----------------------------------------------------------------------
if vim.g.__terminal_plugin__ then
	return true
end
vim.g.__terminal_plugin__ = true

require("defer").lazy(function()
	vim.cmd([[packadd toggleterm.nvim]])
	require("toggleterm").setup({
		open_mapping = [[<c-t>]],
		shade_terminals = false,
		direction = "float",
		winbar = {
			enabled = true,
		},
	})
end)
