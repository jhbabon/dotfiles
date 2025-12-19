---Setup markdown environment
-----------------------------------------------------------------------
if vim.g.__markdown_plugin__ then
	return
end
vim.g.__markdown_plugin__ = true

vim.api.nvim_create_autocmd("User", {
	pattern = "Bootstrap",
	callback = function()
		-- Ensure treesitter syntax is installed
		require("nvim-treesitter").install({ "markdown", "markdown_inline" }):wait(30000)
	end,
})
