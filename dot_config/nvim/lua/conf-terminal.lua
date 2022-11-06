return function()
	require("lazy").load(function()
		local setup = require("fp").once(function()
			vim.cmd.packadd("FTerm.nvim")

			require("FTerm").setup({})
		end)

		local function terminal()
			setup()

			return require("FTerm").toggle()
		end

		local keychain = require("keychain")
		keychain.set({ "n", "t" }, [[<C-\>t]], terminal, { hint = { "terminal", "toggle terminal" } })
	end)
end
