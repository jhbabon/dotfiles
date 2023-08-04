if vim.g.__format_plugin__ then
	return
end
vim.g.__format_plugin__ = true

-- TODO: Review User events' names
-- TODO: If EFM goes well I won't need this

require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.DEBUG,
})

local group = vim.api.nvim_create_augroup("MyFormatting", { clear = true })
vim.api.nvim_create_autocmd("User", {
	group = group,
	pattern = "MyFormatterInject",
	callback = function(event)
		local new_config = event.data
		local updated = vim.tbl_deep_extend("force", require("formatter.config").values, new_config)

		require("formatter").setup(updated)
	end,
})
