-- File Explorer configuration

if vim.g.__explorer_plugin__ then
	return
end
vim.g.__explorer_plugin__ = true

require("offload")(function()
	local function setup()
		vim.cmd([[packadd dirbuf]])

		require("dirbuf").setup({
			write_cmd = "DirbufSync -confirm",
		})
	end

	local jit = require("jits")({ name = "dirbuf", setup = setup })

	local dirbuf = jit(function()
		if vim.bo.filetype == "dirbuf" then
			require("dirbuf").quit()
		else
			require("dirbuf").open("")
		end
	end)

	vim.keymap.set("n", "<leader>ft", dirbuf, { desc = require("tools").desc({ "files", "explore files with Dirbuf" }) })
end)
