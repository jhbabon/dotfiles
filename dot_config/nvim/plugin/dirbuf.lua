---Configure dirbuf plugin: https://github.com/elihunter173/dirbuf.nvim
-- Dirbuf: A file manager for Neovim which lets you edit your filesystem
-- like you edit text
-----------------------------------------------------------------------
if vim.g.__dirbuf_plugin__ then
	return
end
vim.g.__dirbuf_plugin__ = true

local defer = require("defer")

defer.offload(function()
	local function setup()
		require("dirbuf").setup({
			write_cmd = "DirbufSync -confirm",
		})
	end

	local wrap = defer.jits("dirbuf", setup)

	-- toggle dirbuf window
	local dirbuf = wrap(function()
		if vim.bo.filetype == "dirbuf" then
			require("dirbuf").quit()
		else
			require("dirbuf").open("")
		end
	end)

	vim.keymap.set("n", "<leader>ft", dirbuf, { desc = _G.desc({ "files", "explore files with Dirbuf" }) })
end)
