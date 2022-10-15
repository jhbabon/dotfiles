return function()
	require("lazy").load(function()
		local setup = require("fp").once(function()
			vim.cmd.packadd([[dirbuf.nvim]])

			require("dirbuf").setup({
				write_cmd = "DirbufSync -confirm",
			})
		end)

		local keychain = require("keychain")
		local function dirbuf()
			setup()

			if vim.bo.filetype == "dirbuf" then
				require("dirbuf").quit()
			else
				require("dirbuf").open("")
			end
		end

		keychain.set("n", "<leader>ft", dirbuf, { hint = { "files", "explore files with Dirbuf" } })
	end)
end
