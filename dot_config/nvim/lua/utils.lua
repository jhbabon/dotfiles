--- Utils: functions to set mappings and execute VIM code
-- @module utils
local utils = {}

--- Execute the given vim command
-- @tparam string command
function utils.exec(command)
	vim.api.nvim_exec(command, false)
end

--- Execute multiple exec commands at once
-- @param table commands
function utils.multi_exec(commands)
	utils.exec(table.concat(commands, "\n"))
end

-- Create an augroup and return a table for defining autocmds in this augroup.
-- Original function from https://github.com/potamides/dotfiles/blob/master/.config/nvim/lua/au.lua
function utils.au(group)
	local augroup = { _mt = {} }
	-- Define new autocmds with au("<group>").<event> = function() ... end.
	function augroup._mt.__newindex(_, event, handler)
		vim.api.nvim_create_autocmd(event, {
			group = group,
			callback = handler,
		})
	end
	-- With multiple events, or specific opts use au("<group>")(<event>, [<opts>])...
	function augroup._mt.__call(_, event, opts)
		opts = opts or {}
		local autocmd = { _mt = {} }
		-- ... and then define a handler in the returned table, the key doesn't matter.
		function autocmd._mt.__newindex(_, _, handler)
			opts.group = group
			opts.callback = handler
			vim.api.nvim_create_autocmd(event, opts)
		end
		return setmetatable(autocmd, autocmd._mt)
	end
	if group then
		vim.api.nvim_create_augroup(group, { clear = true })
	end
	return setmetatable(augroup, augroup._mt)
end
return utils
