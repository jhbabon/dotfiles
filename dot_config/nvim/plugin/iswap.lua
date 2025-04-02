---Configure iswap plugin: https://github.com/mizlan/iswap.nvim
-- Interactively select and swap function arguments, list elements,
-- and much more. Powered by tree-sitter.
-----------------------------------------------------------------------
if vim.g.__iswap_plugin__ then
	return
end
vim.g.__iswap_plugin__ = true

local defer = require("defer")
defer.very_lazy(function()
	local function setup()
		vim.cmd([[packadd iswap.nvim]])
		require("iswap").setup({})
	end

	local wrap = defer.jits.iswap(setup)

	local swap_params = wrap(function()
		vim.cmd([[ISwap]])
	end)
	local swap_nodes = wrap(function()
		vim.cmd([[ISwapNode]])
	end)

	local cx = require("clue")("n", "cx", "iswap")
	vim.keymap.set("n", cx.p, swap_params, { desc = "exchange params" })
	vim.keymap.set("n", cx.n, swap_nodes, { desc = "exchange nodes" })
end)
