---Toggle relative number setting only on focused buffers
-- based on https://github.com/sitiom/nvim-numbertoggle
-----------------------------------------------------------------------
if vim.g.__numbers_plugin__ then
	return true
end
vim.g.__numbers_plugin__ = true

local augroup = vim.api.nvim_create_augroup("numbers", { clear = true })

-- Enable relative numbers when focusing on a buffer
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
	pattern = "*",
	group = augroup,
	callback = function()
		if vim.opt.nu:get() and vim.api.nvim_get_mode().mode ~= "i" then
			vim.opt.relativenumber = true
		end
	end,
})

-- Disable relative numbers when unfocusing a buffer
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
	pattern = "*",
	group = augroup,
	callback = function(options)
		if not vim.opt.nu:get() then
			return
		end

		vim.opt.relativenumber = false

		-- We only need to redraw on CmdlineEnter and NOT debug mode (the file is the char ">")
		if options.event == "CmdlineEnter" and options.file ~= ">" then
			vim.cmd.redraw()
		end
	end,
})
