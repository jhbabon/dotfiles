-- Try to offload work to VimEnter event
local lazy = {}
local group = vim.api.nvim_create_augroup("__lazy__", { clear = true })

function lazy.load(callback)
	vim.api.nvim_create_autocmd("VimEnter", {
		group = group,
		pattern = { "*" },
		callback = vim.schedule_wrap(callback),
	})
end

local callable = {}
function callable.__call(lz, callback)
	lz.load(callback)
end

setmetatable(lazy, callable)

return lazy
