if vim.g.__iswap_plugin__ then
	return
end
vim.g.__iswap_plugin__ = true

require("offload")(function()
	require("iswap").setup({})
end)
