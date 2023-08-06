-- File Explorer configuration

if vim.g.__explorer_plugin__ then
	return
end
vim.g.__explorer_plugin__ = true

local defer = require("defer")

defer.offload(function()
	local function setup()
		require("dirbuf").setup({
			write_cmd = "DirbufSync -confirm",
		})
	end

	local wrap = defer.jits({ name = "dirbuf", setup = setup })

	local dirbuf = wrap(function()
		if vim.bo.filetype == "dirbuf" then
			require("dirbuf").quit()
		else
			require("dirbuf").open("")
		end
	end)

	vim.keymap.set("n", "<leader>ft", dirbuf, { desc = _G.desc({ "files", "explore files with Dirbuf" }) })
end)
