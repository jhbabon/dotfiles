return function()
	require("dirbuf").setup({
		write_cmd = "DirbufSync -confirm",
	})

	local keychain = require("keychain")
	local function dirbuf()
		if vim.bo.filetype == "dirbuf" then
			require("dirbuf").quit()
		else
			require("dirbuf").open()
		end
	end

	keychain.set("n", "<leader>ft", dirbuf, { hint = { "files", "explore files with Dirbuf" } })
end
