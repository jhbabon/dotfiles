---Configure dirbuf plugin: https://github.com/elihunter173/dirbuf.nvim
-- Dirbuf: A file manager for Neovim which lets you edit your filesystem
-- like you edit text
-----------------------------------------------------------------------
if vim.g.__dirbuf_plugin__ then
	return
end
vim.g.__dirbuf_plugin__ = true

local defer = require("defer")

defer.very_lazy(function()
	local function setup()
		vim.cmd([[packadd dirbuf.nvim]])
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

	local _f = require("clue")("n", "<leader>f", "files")
	vim.keymap.set("n", _f.t, dirbuf, { desc = "explore files with Dirbuf" })
end)
