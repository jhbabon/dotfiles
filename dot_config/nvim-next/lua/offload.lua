local group = vim.api.nvim_create_augroup("__offload__", { clear = true })

-- Offload the execution of a function until VimEnter has been triggered
local function offload(fn)
	vim.api.nvim_create_autocmd("VimEnter", {
		group = group,
		pattern = { "*" },
		callback = vim.schedule_wrap(fn),
	})
end

return offload
