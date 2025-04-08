---Configure treesj plugin: Wansmer/treesj
-- Neovim plugin for splitting/joining blocks of code
-----------------------------------------------------------------------
if vim.g.__treesj_plugin__ then
	return
end
vim.g.__treesj_plugin__ = true

require("defer").very_lazy(function()
	local function setup()
		vim.cmd([[packadd treesj]])
		require("treesj").setup({
			use_default_keymaps = false,
		})
	end

	local wrap = require("defer").jits.treesj(setup)
	local join = wrap(function()
		require("treesj").join()
	end)

	local split = wrap(function()
		require("treesj").split()
	end)

	local clue = require("clue")
	local _b = clue("n", "<leader>b", "block editing")

	vim.keymap.set("n", _b.j, join, { desc = "join current block of code" })
	vim.keymap.set("n", _b.s, split, { desc = "split current block of code" })
end)
