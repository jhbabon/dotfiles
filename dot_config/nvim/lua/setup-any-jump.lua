return function()
	vim.g.any_jump_disable_default_keybindings = true
	local keychain = require("keychain")

	keychain.set("n", "<leader>jw", [[:AnyJump<cr>]], { hint = { "jump", "current word" } })
	keychain.set("x", "<leader>jw", [[:AnyJumpVisual<cr>]], { hint = { "jump", "current word" } })
	keychain.set("n", "<leader>jb", [[:AnyJumpBack<cr>]], { hint = { "jump", "previous file" } })
	keychain.set("n", "<leader>jl", [[:AnyJumpLastResults<cr>]], { hint = { "jump", "last results" } })
end
