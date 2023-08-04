if vim.g.__format_lua_plugin__ then
	return
end
vim.g.__format_lua_plugin__ = true

local _ = require("fun")
local option = require("option")
local binaries = require("binaries")

vim.api.nvim_create_autocmd("FileType", {
	once = true,
	pattern = { "lua" },
	callback = vim.schedule_wrap(function()
		local bin = binaries.prepare("stylua")
		bin:resolve(option.wrap_some(function(exec)
			local exe = exec.cmd.string()
			local stylua = function()
				return _.tap(require("formatter.filetypes.lua").stylua(), function(opts)
					opts.exe = exe
				end)
			end

			vim.api.nvim_exec_autocmds("User", {
				pattern = "MyFormatterInject",
				data = {
					filetype = {
						lua = { stylua },
					},
				},
			})
		end))
	end),
})
