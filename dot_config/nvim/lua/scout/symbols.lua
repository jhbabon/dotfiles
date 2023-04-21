-- Jump to a symbol in the current file using aerial.nvim info
local core = require("scout.core")
local u = require("scout.utils")

local backends = require("aerial.backends")
local data = require("aerial.data")
local navigation = require("aerial.navigation")
local config = require("aerial.config")

local M = {}

local function encode(item)
	local icon = config.get_icon(0, item.kind, false)

	return ("%s %s #%d"):format(icon, item.name, item.idx)
end

local function decode(str)
	return tonumber(str:match("#(%d+)$"))
end

local function list()
	local backend = backends.get()
	if not backend then
		backends.log_support_err()
		return nil
	elseif not data.has_symbols(0) then
		backend.fetch_symbols_sync(0, {})
	end
	local results = {}
	if data.has_symbols(0) then
		for _, item in data.get_or_create(0):iter({ skip_hidden = false }) do
			table.insert(results, encode(item))
		end
	end
	return results
end

local function goto(selection)
	local id = decode(selection)
	local goto_id
	for i, _, symbol_idx in data.get_or_create(0):iter({ skip_hidden = false }) do
		if id == i then
			goto_id = symbol_idx
			break
		end
	end

	navigation.select({ index = goto_id })
end

function M.run(options)
	local opts = options or {}

	core.run({
		search = opts.search,
		list = list(),
		done = function(selection, _)
			if u.is_empty(selection) then
				return
			end

			goto(selection)
		end,
		title = "document symbols",
	})
end

return M
