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
		require("spectre").setup()
	end

	local wrap = defer.jits({ name = "spectre", setup = setup })

	local open = wrap(function()
		require("spectre").open({})
	end)

	vim.keymap.set("n", "<leader>sp", open, { desc = _G.desc({ "spectre", "open" }) })
end)
