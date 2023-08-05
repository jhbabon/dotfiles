--- Find executables in different scopes and build commands with them
-- @usage
-- local scopes = require("execs.scopes")
-- local spec = {
--	"efm-langserver",
--	scopes = {
--		scopes.system,
--		-- scopes.mason, -- default definition
--		scopes.mason.pkg({ version = "v1", name = "efm", bin = "efm-langserver" }),
--	},
-- }
-- requier("execs").resolve(spec, function(opt)
--	if opt:is_some() then
--		print("found %s":format(opt:unwrap()))
--	else
--		print("not found %s":format(spec.name))
--	end
-- end)

local async = require("plenary.async")
local option = require("option")
local scopes = require("execs.scopes")

---@module 'execs'
local execs = {}

-- Internal cache for all resolved executables
local cache = {}

---@class ExecSpec
---@field [1] string the name of the executable
---@field scopes table<Scope>? list of scope functions

---@class Exec
---@field scpe ExecSpec
---@field cmd string[]
local Exec = {}
Exec.__index = Exec

---@param spec ExecSpec
---@param cmd string[]
function Exec.new(spec, cmd)
	return setmetatable({ spec = spec, cmd = cmd }, Exec)
end

function Exec:__tostring()
	return table.concat(self.cmd, " ")
end

---@param spec string|ExecSpec
---@param callback fun(opt: Option<Exec>): nil
function execs.resolve(spec, callback)
	assert(spec, "this method expects an executable specification as a string got ExecSpec")
	local function resolve()
		if type(spec) == "string" then
			spec = { spec }
		end

		spec.scopes = spec.scopes or { scopes.system, scopes.mason }

		local name = spec[1]
		if cache[name] ~= nil then
			local cached = cache[name]
			return cached:map(function(cmd)
				Exec.new(spec, cmd)
			end)
		end

		local acc = option.none()
		for _, scope in ipairs(spec.scopes) do
			acc = acc:or_else(function()
				return scope(name)
			end)
		end

		-- save the option value so if none of the resolvers
		-- found it, it won't try again later
		cache[name] = acc

		return acc:map(function(cmd)
			return Exec.new(spec, cmd)
		end)
	end

	async.run(resolve, callback)
end

return execs
