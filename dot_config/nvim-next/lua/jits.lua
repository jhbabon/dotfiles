local pattern = "JITSetupPre"

-- JITS: Just In Time Setup
-- Execute the setup of a module/plugin once just before an action is required
-- TODO: Better docs
local function jits(options)
	local name = options.name
	assert(name, "module name is missing")
	local setup = options.setup
	assert(setup, "module setup function is missing")

	-- Create an augroup associated to this module
	local group = vim.api.nvim_create_augroup(string.format("__jits_%s__", name), { clear = true })

	-- Register a User's event that executes the setup only once
	vim.api.nvim_create_autocmd("User", {
		group = group,
		pattern = pattern,
		once = true,
		callback = setup,
	})

	-- This wrapper will wrap a function so it is executed
	-- under the defined User's commands, that way the setup it's
	-- executed the first time.
	return function(fn)
		return function()
			vim.api.nvim_exec_autocmds("User", { group = group, pattern = pattern })

			fn()
		end
	end
end

return jits
