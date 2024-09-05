---Configure spectre plugin: https://github.com/nvim-pack/nvim-spectre
-- A search panel for neovim
-----------------------------------------------------------------------
if vim.g.__spectre_plugin__ then
	return true
end
vim.g.__spectre_plugin__ = true

local defer = require("defer")

defer.offload(function()
	local function setup()
		vim.cmd([[packadd nvim-spectre]])
		require("spectre").setup()
	end

	local wrap = defer.jits.spectre(setup)

	local open = wrap(function()
		require("spectre").open({})
	end)

	local _s = require("clue")("n", "<leader>s", "spectre")
	vim.keymap.set("n", _s.p, open, { desc = "open spectre" })
end)
