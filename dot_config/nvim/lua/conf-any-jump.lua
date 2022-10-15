return function()
	vim.g.any_jump_disable_default_keybindings = true
	require("lazy").load(function()
		local setup = require("fp").once(function()
			vim.cmd.packadd("any-jump.vim")
		end)

		local function jump(cmd)
			return function()
				setup()

				vim.cmd(cmd)
			end
		end

		local keychain = require("keychain")

		keychain.set("n", "<leader>jw", jump([[AnyJump]]), { hint = { "jump", "current word" } })
		keychain.set("x", "<leader>jw", jump([[AnyJumpVisual]]), { hint = { "jump", "current word" } })
		keychain.set("n", "<leader>jb", jump([[AnyJumpBack]]), { hint = { "jump", "previous file" } })
		keychain.set("n", "<leader>jl", jump([[AnyJumpLastResults]]), { hint = { "jump", "last results" } })
	end)
end
