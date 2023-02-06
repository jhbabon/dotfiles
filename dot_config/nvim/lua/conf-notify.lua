return function()
	local notify = require("notify")
	notify.setup({
		level = vim.log.levels.INFO,
	})

	-- Change the main vim.notify function to use this plugin
	vim.notify = require("notifications").decorate(notify)
end
