---Ensure helptags are up to date
-----------------------------------------------------------------------
if vim.g.__helptags_plugin__ then
	return
end
vim.g.__helptags_plugin__ = true

-- Generate all helptags when bootstrapping
vim.api.nvim_create_autocmd("User", {
	pattern = "Bootstrap",
	callback = function()
		vim.cmd([[silent! helptags ALL]])
	end,
})
