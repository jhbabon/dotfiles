---Configure configure precognition plugin: https://github.com/tris203/precognition.nvim
-- Precognition uses virtual text and gutter signs to show available motions.
-----------------------------------------------------------------------
if vim.g.__precognition_plugin__ then
	return true
end
vim.g.__precognition_plugin__ = true

local defer = require("defer")

defer.very_lazy(function()
	local function setup()
		vim.cmd([[packadd precognition.nvim]])
		require("precognition").setup({
			startVisible = false,
			showBlankVirtLine = false,
		})
	end

	local wrap = defer.jits.precognition(setup)

	local toggle = wrap(function()
		require("precognition").toggle()
	end)

	local _p = require("clue")("n", "<leader>p", "precognition")
	vim.keymap.set("n", _p.t, toggle, { desc = "toggle precognition" })
end)
