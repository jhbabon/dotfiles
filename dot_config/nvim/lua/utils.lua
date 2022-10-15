--- Utils: functions to help around
---@module 'utils'
local utils = {}

--- Execute the given vim command
---@param command string
function utils.exec(command)
	vim.api.nvim_exec(command, false)
end

--- Execute multiple exec commands at once
---@param commands string[]
function utils.multi_exec(commands)
	utils.exec(table.concat(commands, "\n"))
end

return utils
