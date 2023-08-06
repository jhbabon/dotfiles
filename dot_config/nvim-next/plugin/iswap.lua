---Configure iswap plugin: https://github.com/mizlan/iswap.nvim
-- Interactively select and swap function arguments, list elements,
-- and much more. Powered by tree-sitter.
-----------------------------------------------------------------------
if vim.g.__iswap_plugin__ then
	return
end
vim.g.__iswap_plugin__ = true

require("defer").offload(function()
	require("iswap").setup({})

	vim.keymap.set("n", "cxp", [[:ISwap<cr>]], { desc = _G.desc({ "iswap", "exchange params" }) })
	vim.keymap.set("n", "cxn", [[:ISwapNode<cr>]], { desc = _G.desc({ "iswap", "exchange nodes" }) })
end)
