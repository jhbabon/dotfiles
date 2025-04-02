---Configure grug-far plugin: https://github.com/MagicDuck/grug-far.nvim
-- Find And Replace plugin for neovim
-----------------------------------------------------------------------
if vim.g.__grugfar_plugin__ then
	return
end
vim.g.__grugfar_plugin__ = true

require("defer").very_lazy(function()
	local function setup()
		vim.cmd([[packadd grug-far.nvim]])
		require("grug-far").setup({})
	end

	local wrap = require("defer").jits.grugfar(setup)

	local open = wrap(function()
		require("grug-far").open({ engine = "astgrep", transient = true })
	end)

	vim.keymap.set("n", "<leader>r", open, { desc = "search and replace" })
end)
