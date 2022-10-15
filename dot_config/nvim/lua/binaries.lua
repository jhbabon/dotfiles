--[[
--Manage binaries
--
--This module tries to find the path to a given binary using different lookup systems
--
--The main one is the system lookup, this tries to find the binary in the current system
--Then there is the mason lookup. It tries to check if is present in Mason, and if not,
--it tries to install it.
--
--Given how Mason installation works, the whole process to find and install is async
--]]
---@module 'binaries'
local binaries = {}

-- TODO: Better docs and cleanup

local option = require("option")

local async = require("plenary.async")
local registry = require("mason-registry")
local path = require("mason-core.path")

-- Global binary paths cache
local cache = {}
-- Lookup functions
local lookups = {}

-- Default system lookup
function lookups.system(spec)
	if vim.fn.executable(spec.name) == 0 then
		return option.none()
	end

	return option.some({ spec.name })
end

-- Try to find a binary in the local `bin/` dir
function lookups.local_bin(spec)
	local pkg = vim.tbl_extend("force", spec, { name = ("bin/%s"):format(spec.name) })

	return lookups.system(pkg)
end

-- Try to find a binary in the local `node_modules/.bin/` dir
function lookups.node_module(spec)
	local pkg = vim.tbl_extend("force", spec, { name = ("node_modules/.bin/%s"):format(spec.name) })

	return lookups.system(pkg)
end

-- Append extra arguments to whatever command the lookup finds
function lookups.append(lookup, extra)
	return function(spec)
		return lookup(spec):and_then(function(cmd)
			for _, ext in ipairs(extra) do
				table.insert(cmd, ext)
			end

			return option.some(cmd)
		end)
	end
end

-- Only run a lookup if an executable is present in the system.
-- For example, only run mason if "npm" is present
--   binaries.lookups.if_exec("npm", binaries.lookups.mason)
function lookups.if_exec(executable, lookup)
	return function(spec)
		return lookups.system({ name = executable }):and_then(function()
			return lookup(spec)
		end)
	end
end

-- Try to find the binary in Mason and install it if is not present
function lookups.mason(spec)
	local pkg = registry.get_package(spec.name)

	if pkg:is_installed() then
		return option.some({ path.bin_prefix(pkg.name) })
	end

	local sender, receiver = async.control.channel.oneshot()

	pkg:install({ version = spec.version }):once(
		"closed",
		vim.schedule_wrap(function()
			if pkg:is_installed() then
				sender({ path.bin_prefix(pkg.name) })
			end
		end)
	)

	return option.some(receiver())
end

binaries.lookups = lookups

local noop = function() end

-- Convert a found command (a string[]) into an executable table
local function executable(found, spec)
	local cmd = {
		string = function()
			return table.concat(found, " ")
		end,
	}
	setmetatable(cmd, {
		__call = function(_)
			return found
		end,
	})

	return {
		cmd = cmd,
		spec = spec,
	}
end

-- Callback to run in an option:or_else call
-- It prints that the binary was not found and returns option.none
local function not_found(name)
	return function()
		print(("[binaries] not found: %s"):format(name))

		return option.none()
	end
end

-- Callback to run in an option:and_then call
-- Transforms the given spec and cmd into an option.some(executable) object
local function to_exec(spec)
	return function(cmd)
		return option.some(executable(cmd, spec))
	end
end

-- Prepare a new binary resolver
function binaries.prepare(spec, looks)
	if type(spec) == "string" then
		spec = { name = spec }
	end

	looks = looks or {
		lookups.system,
		lookups.mason,
	}

	local bin = {
		spec = spec,
		lookups = looks,
	}

	-- Resolve will iterate over the given lookups.
	-- If something is found, that will be used in the callback function
	-- Any value found (Some or None) will be cached to prevent future lookups
	function bin:resolve(callback)
		local function resolve()
			if cache[self.spec.name] ~= nil then
				local cached = cache[self.spec.name]
				return cached:and_then(to_exec(self.spec))
			end

			local acc = option.none()
			for _, lookup in ipairs(self.lookups) do
				acc = acc:or_else(function()
					return lookup(self.spec)
				end)
			end

			-- save the option value so if none of the resolvers
			-- found it, it won't try again later
			cache[self.spec.name] = acc

			return acc:or_else(not_found(self.spec.name)):and_then(to_exec(self.spec))
		end

		vim.schedule(function()
			async.run(resolve, callback)
		end)
	end

	return bin
end

-- Prepare many binary resolvers at the same time
-- They will be all resolved and the callback function will be executed once
-- with all the results
function binaries.prepare_many(specs)
	local channels = {}
	local bins = {}
	for index, spec in ipairs(specs) do
		local sender, receiver = async.control.channel.oneshot()
		table.insert(channels, index, receiver)

		local bin = binaries.prepare(spec[1], spec[2])
		table.insert(bins, index, { bin, sender })
	end

	local collection = {
		specs = specs,
		channels = channels,
		bins = bins,
	}

	function collection:resolve(callback)
		vim.schedule(function()
			-- Run resolvers per spec
			async.run(function()
				for _, pack in ipairs(self.bins) do
					local bin = pack[1]
					local sender = pack[2]

					bin:resolve(sender)
				end
			end, noop)

			-- Collect resolvers' results
			async.run(function()
				local results = {}
				for index, receiver in ipairs(self.channels) do
					local result = receiver()
					local spec = self.specs[index][1]
					results[spec.name] = result
				end

				return results
			end, callback)
		end)
	end

	return collection
end

return binaries
