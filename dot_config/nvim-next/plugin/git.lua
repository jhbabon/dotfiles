if vim.g.__git_plugin__ then
	return
end
vim.g.__git_plugin__ = true

require("offload")(function()
	vim.cmd([[packadd neogit]])
	require("neogit").setup({})

	local tools = require("tools")

	local function open()
		require("neogit").open()
	end

	local function commit()
		require("neogit").open({ "commit" })
	end

	vim.keymap.set("n", "<leader>gs", open, { desc = tools.desc({ "git", "status" }) })
	vim.keymap.set("n", "<leader>gc", commit, { desc = tools.desc({ "git", "commit" }) })
end)
