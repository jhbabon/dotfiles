---Configure ssr plugin: cshuaimin/ssr.nvim
-- Treesitter based structural search and replace plugin for Neovim.
-----------------------------------------------------------------------
if vim.g.__ssr_plugin__ then
	return
end
vim.g.__ssr_plugin__ = true

require("defer").very_lazy(function()
	local function setup()
		vim.cmd([[packadd ssr.nvim]])
		require("ssr").setup()
	end

	local wrap = require("defer").jits.ssr(setup)
	local open = wrap(function()
		require("ssr").open()
	end)

	local clue = require("clue")

	local _s = clue({ "n", "x" }, "<leader>s", "search")
	vim.keymap.set({ "n", "x" }, _s.r, open, { desc = "structural search and replace" })
end)
