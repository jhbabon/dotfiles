---Configure nvim_context_vt plugin: andersevenrud/nvim_context_vt
-- Virtual text context for neovim treesitter
-----------------------------------------------------------------------
if vim.g.__context_plugin__ then
	return
end
vim.g.__context_plugin__ = true

require("defer").very_lazy(function()
	vim.cmd([[packadd nvim_context_vt]])
end)
