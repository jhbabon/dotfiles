-- Jump to a symbol in the current file using aerial.nvim info
local core = require("scout.core")
local u = require("scout.utils")

local aerial = {
	backends = require("aerial.backends"),
	data = require("aerial.data"),
	navigation = require("aerial.navigation"),
	config = require("aerial.config"),
}

local M = {}

local function encode(item)
	local icon = aerial.config.get_icon(0, item.kind, false)

	return ("%s %s #%d"):format(icon, item.name, item.idx)
end

local function decode(str)
	return tonumber(str:match("#(%d+)$"))
end

local function list()
	local backend = aerial.backends.get()
	if not backend then
		aerial.backends.log_support_err()
		return nil
	elseif not aerial.data.has_symbols(0) then
		backend.fetch_symbols_sync(0, {})
	end
	local results = {}
	if aerial.data.has_symbols(0) then
		for _, item in aerial.data.get_or_create(0):iter({ skip_hidden = false }) do
			table.insert(results, encode(item))
		end
	end
	return results
end

local function goto_symbol(selection)
	local id = decode(selection)
	local goto_id
	for i, _, symbol_idx in aerial.data.get_or_create(0):iter({ skip_hidden = false }) do
		if id == i then
			goto_id = symbol_idx
			break
		end
	end

	aerial.navigation.select({ index = goto_id })
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

			goto_symbol(selection)
		end,
		title = "document symbols",
	})
end

return M
