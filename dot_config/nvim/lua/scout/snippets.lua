-- Experimental module to fuzzy search snippets with scout
-- Selecting a snippet from the list will insert and expand it
-- like writing the trigger + <tab> in insert mode
local fmt = string.format
local core = require("scout.core")
local u = require("scout.utils")

local M = {}

local function snippets()
	local count = 1
	local collection = {}
	local available = require("luasnip").available()

	for ft, list in pairs(available) do
		for _, snippet in pairs(list) do
			table.insert(collection, count, {
				id = count,
				ft = ft,
				name = snippet.name,
				trigger = snippet.trigger,
				description = snippet.description,
			})
			count = count + 1
		end
	end

	return collection
end

local function build_list()
	local collection = snippets()
	local list = {}
	for id, snippet in pairs(collection) do
		local description = snippet.description[1] or "no description"
		local line = fmt("%d. %s > %s > %s > %s", id, snippet.ft, snippet.trigger, snippet.name, description)
		table.insert(list, line)
	end

	return list
end

local function open(selection, _)
	if u.is_empty(selection) then
		return
	end

	local id = string.match(selection, "(%d+)%.%s+.*") or ""
	id = tonumber(id)
	if u.is_empty(id) then
		return
	end

	local collection = snippets()
	local snippet = collection[id]
	local trigger = snippet and snippet.trigger
	if u.is_empty(trigger) then
		return
	end

	-- trigger the snippet by entering insert mode, writing the trigger and then <tab>
	vim.fn.feedkeys(fmt("i%s\t", trigger))
end

function M.run(options)
	local opts = options or {}

	core.run({
		search = opts.search,
		list = build_list(),
		done = open,
		title = "snippets",
	})
end

return M
