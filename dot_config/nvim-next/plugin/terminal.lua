if vim.g.__terminal_plugin__ then
	return true
end
vim.g.__terminal_plugin__ = true

require("defer").offload(function()
	require("toggleterm").setup({
		open_mapping = [[<c-t>]],
		shade_terminals = false,
		direction = "float",
		winbar = {
			enabled = true,
		},
	})
end)
