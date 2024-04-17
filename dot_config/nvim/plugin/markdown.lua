---Configure markdown.nvim plugin: https://github.com/MeanderingProgrammer/markdown.nvim
-- Plugin to improve viewing Markdown files in Neovim
-----------------------------------------------------------------------
if vim.g.__markdown_plugin__ then
	return
end
vim.g.__markdown_plugin__ = true

vim.api.nvim_create_autocmd("User", {
	pattern = "Bootstrap",
	callback = function()
		-- Ensure treesitter syntax is installed
		vim.cmd([[TSInstallSync! markdown markdown_inline]])
	end,
})

require("defer").offload(function()
	require("render-markdown").setup({})
end)
