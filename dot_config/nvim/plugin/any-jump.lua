---Configure any-jump plugin: https://github.com/pechorin/any-jump.vim
-- Jump to any definition and references
-----------------------------------------------------------------------
if vim.g.__anyjump_plugin__ then
	return
end
vim.g.__anyjump_plugin__ = true

local defer = require("defer")

defer.offload(function()
	local function setup()
		vim.g.any_jump_disable_default_keybindings = true
		vim.cmd([[packadd any-jump.vim]])
	end

	local wrap = defer.jits.any_jump(setup)

	local jump = wrap(function()
		vim.cmd([[AnyJump]])
	end)
	local jump_visual = wrap(function()
		vim.cmd([[AnyJumpVisual]])
	end)
	local jump_back = wrap(function()
		vim.cmd([[AnyJumpBack]])
	end)
	local jump_last = wrap(function()
		vim.cmd([[AnyJumpLastResults]])
	end)

	local clue = require("clue")
	clue({ "n", "x" }, "<leader>j", "jump")
	vim.keymap.set("n", "<leader>jw", jump, { desc = "jump to current word" })
	vim.keymap.set("x", "<leader>jw", jump_visual, { desc = "jump to current word" })
	vim.keymap.set("n", "<leader>jb", jump_back, { desc = "jump to previous file" })
	vim.keymap.set("n", "<leader>jl", jump_last, { desc = "jump to last results" })
end)
