---Configure snippy plugin: https://github.com/dcampos/nvim-snippy
-- Snippet plugin for Neovim written in Lua
-----------------------------------------------------------------------
if vim.g.__snippets_plugin__ then
	return
end
vim.g.__snippets_plugin__ = true

require("defer").offload(function()
	require("snippy").setup({})

	local mappings = require("snippy.mapping")

	vim.keymap.set("i", "<Tab>", mappings.expand_or_advance("<Tab>"))
	vim.keymap.set("s", "<Tab>", mappings.next("<Tab>"))
	vim.keymap.set({ "i", "s" }, "<S-Tab>", mappings.previous("<S-Tab>"))
	vim.keymap.set("x", "<Tab>", mappings.cut_text, { remap = true })
	vim.keymap.set("n", "g<Tab>", mappings.cut_text, { remap = true })

	-- Snippets menu
	vim.keymap.set("i", "<c-r><tab>", function()
		require("snippy").complete()
	end)

	local group = vim.api.nvim_create_augroup("__snippy_complete__", { clear = true })
	vim.api.nvim_create_autocmd("CompleteDone", {
		group = group,
		callback = function()
			require("snippy").complete_done()
		end,
	})
end)
