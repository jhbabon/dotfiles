---Collection of tools to execute code as late as possible

---@module 'defer'
local defer = {}

local group = vim.api.nvim_create_augroup("__defer__", { clear = true })

---@class OffloadSpec
---@field event string the name of the vim event

---Offload the execution of a function until the given event has been triggered. By default is VimEnter
---@param callback fun()
---@param options OffloadSpec|nil
function defer.lazy(callback, options)
	options = options or {}
	local event = options.event or "VimEnter"
	vim.api.nvim_create_autocmd(event, {
		group = group,
		pattern = { "*" },
		callback = vim.schedule_wrap(callback),
	})
end

---Offload the execution of a function until UIEnter has been triggered
---@param callback fun()
function defer.very_lazy(callback)
	defer.lazy(callback, { event = "UIEnter" })
end

---JITS: Just In Time Setup
-- The idea is to defer the setup of a module to just before
-- it is going to be used by a function.
-- This works in two steps:
-- - Build a wrapper function that will ensure a setup is triggered once
-- - Wrap functions that use the module with this wrapper, so they trigger
--   the setup the first time
--
---@usage
---	local setup = function() vim.cmd.packadd("any-jump.vim") end -- setup the module
---	local wrapper = require("defer").jits.any_jump(setup)
---	local jump = wrapper(function()
---		vim.cmd([[AnyJump]])
---	end)
---	jump() -- the first time it will trigger the setup before running
---	jump() -- the second time it will run normally
--
---@param name string name of the module to lazy load
---@param setup fun() setup function
---@return fun(callback: fun()): fun()
local function _jits(name, setup)
	assert(name, "module name is missing")
	assert(setup, "module setup function is missing")

	local pattern = "JITSetupPre"

	-- Create an augroup associated to this action
	local jits_group = vim.api.nvim_create_augroup(string.format("__jits_%s__", name), { clear = true })

	-- Register a User's event that executes the setup only once
	vim.api.nvim_create_autocmd("User", {
		group = jits_group,
		pattern = pattern,
		once = true,
		callback = vim.schedule_wrap(function(event)
			-- Run the setup, this will be done only once
			setup()

			-- Register a new autcmd for this pattern and group
			vim.api.nvim_create_autocmd("User", {
				group = jits_group,
				pattern = pattern,
				callback = function(ev)
					-- Execute the event's function
					ev.data.fn()
				end,
			})

			-- Act normal
			event.data.fn()
		end),
	})

	-- This wrapper will wrap a function so it is executed
	-- under the defined User's commands, that way the setup it's
	-- executed the first time.
	return function(fn)
		return function()
			vim.api.nvim_exec_autocmds("User", { group = jits_group, pattern = pattern, data = { fn = fn } })
		end
	end
end

local jits = {}
setmetatable(jits, {
	__index = function(_, key)
		local function setup(callback)
			return _jits(key, callback)
		end

		return setup
	end,

	__call = function(_, ...)
		return _jits(...)
	end,
})

defer.jits = jits

return defer
