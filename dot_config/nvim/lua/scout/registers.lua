-- Experimental module that shows all the latest yanks in scout
-- It uses neoclip as a backend
-- TODO: Maybe just use ":registers"?
local u = require("scout.utils")
local core = require("scout.core")
local handlers = require("neoclip.handlers")

local M = {}

local operations = {
	["enter"] = function(entry)
		handlers.paste(entry, "p")
	end,
	["c-v"] = function(entry)
		handlers.paste(entry, "P")
	end,
	["c-x"] = function(entry)
		handlers.set_registers({ '"' }, entry)
	end,
	["c-t"] = function(entry)
		handlers.set_registers({ "a" }, entry)
	end,
}

local function prepare()
	local storage = require("neoclip.storage").get().yanks
	local list = {}
	for index, entry in ipairs(storage) do
		for _, content in ipairs(entry.contents) do
			-- If an entry is multiline, pass each line with the same index
			table.insert(list, ("%d.%s: %s"):format(index, entry.regtype, content))
		end
	end

	return {
		list = list,
		storage = storage,
	}
end

local function open(storage, selection, signal)
	if u.is_empty(selection) then
		return
	end

	local index = tonumber(selection:match("^%d+%."))
	local entry = storage[index]
	if u.is_empty(entry) then
		return
	end

	local op = operations[signal]
	op(entry)
end

-- TODO: Pass registers to paste into?
function M.run(opts)
	opts = opts or {}
	local registers = prepare()

	if next(registers.list) == nil then
		print("scout.registers> empty registry, nothing to do")
		return
	end

	core.run({
		search = opts.search,
		list = registers.list,
		done = function(selection, signal)
			open(registers.storage, selection, signal)
		end,
		title = "registers",
	})
end

return M
