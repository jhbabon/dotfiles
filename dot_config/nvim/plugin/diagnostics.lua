---Configure diagnostics presentation
-----------------------------------------------------------------------
if vim.g.__diagnostics_plugin__ then
	return
end
vim.g.__diagnostics_plugin__ = true

vim.diagnostic.config({
	-- Use the default configuration
	virtual_lines = true,

	-- Alternatively, customize specific options
	-- virtual_lines = {
	-- 	-- Only show virtual line diagnostics for the current cursor line
	-- 	current_line = true,
	-- },
})
