if vim.g.__js_plugin__ then
	return
end
vim.g.__js_plugin__ = true

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	once = true,
	callback = function()
		require("lsp").enable("denols")
	end,
})
