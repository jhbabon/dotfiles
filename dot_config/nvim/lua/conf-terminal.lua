return function()
	require("FTerm").setup({})

	local function terminal()
		return require("FTerm").toggle()
	end

	local keychain = require("keychain")
	keychain.set("n", "<leader>tt", terminal, { hint = { "terminal", "toggle terminal" } })
	keychain.set("t", "<C-\\>tt", terminal)
end
