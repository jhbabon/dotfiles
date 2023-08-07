---Apply layers defined in other plugins
-- This has to be done after all the plugins have been loaded
-----------------------------------------------------------------------
if vim.g.__layers_plugin__ then
	return
end
vim.g.__layers_plugin__ = true

require("layers").apply()
