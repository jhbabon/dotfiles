---Scopes used to find executables
local option = require("option")
local async = require("plenary.async")
local mason_registry = require("mason-registry")
local mason_path = require("mason-core.path")

---@alias Scope fun(name: string): Option<string[]>

---@module 'scopes'
local scopes = {}

---Find an executable in the system
---@param name string the name of the executable
---@return Option<string[]> a table of strings that form the command to execute
function scopes.system(name)
	if vim.fn.executable(name) == 0 then
		return option.none()
	end

	return option.some({ name })
end

---@class PkgOptions
---@field name string the name of the package in Mason
---@field version? string the version to use with Mason
---@field bin? string the name of the executable linked by Mason.
--  If not present, the name of the ExecSpec will be used

---Find an executable with Mason or install it if is not present
---@param name string the name of the executable
---@param options? PkgOptions set of options for Mason
---@return Option<string[]> a table of strings that form the command to execute
local function mason(name, options)
	options = options or { name = name }

	local sender, receiver = async.control.channel.oneshot()

	mason_registry.refresh(function()
		local bin = options.bin or name
		local pkg = mason_registry.get_package(options.name)

		if pkg:is_installed() then
			return sender(option.some({ mason_path.bin_prefix(bin) }))
		end

		pkg:install({ version = options.version }):once(
			"closed",
			vim.schedule_wrap(function()
				if pkg:is_installed() then
					sender(option.some({ mason_path.bin_prefix(bin) }))
				else
					sender(option.none())
				end
			end)
		)
	end)

	return receiver()
end

local mason_proxy = {}

---Build a mason scope with a set of options to find a Mason package in place
---@usage
--	local mason = require("execs.scopes").mason.pkg({ version = "v2", name = "efm" })
--	mason("efm-langserver"):and_then(function(exec) print(vim.inspect(exec)) end)
---@param options PkgOptions
function mason_proxy.pkg(options)
	return function(name)
		return mason(name, options)
	end
end

setmetatable(mason_proxy, {
	__call = function(_, ...)
		return mason(...)
	end,
})
scopes.mason = mason_proxy

return scopes
