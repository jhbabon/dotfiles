---Configure osc52 plugin: https://github.com/ojroques/nvim-osc52
-- A Neovim plugin to copy text through SSH with OSC52
-----------------------------------------------------------------------
if vim.g.__osc52_plugin__ then
	return
end
vim.g.__osc52_plugin__ = true

local defer = require("defer")

defer.offload(function()
	local function setup()
		require("osc52").setup({})
	end

	local wrap = defer.jits({ name = "osc52", setup = setup })

	local copy_operator = wrap(function()
		require("osc52").copy_operator()
	end)
	local copy_visual = wrap(function()
		require("osc52").copy_visual()
	end)

	vim.keymap.set("n", "<leader>o", copy_operator, { expr = true })
	vim.keymap.set("v", "<leader>o", copy_visual)
end)
