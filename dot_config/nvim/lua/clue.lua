---The clue module is a little helper that allows defining
-- groups for clues inside the mini.clue plugin
--
-- Note that since the order of when clues are added is important, the mini.clue setup must be done as late as possible
--
---@usage
--	-- Inside a plugin
--	require("clue")("n", "<leader>f", "files")
--
--	-- Inside mini.clue configuration
--	require("mini.clue").setup({
--		clues = {
--			require("clue").mini(),
--		}
--	})

---@module 'clue'
local clue = { _list = {} }

function clue.mini()
	local mini_clue = {}
	for _, item in pairs(clue._list) do
		table.insert(mini_clue, {
			mode = item.mode,
			keys = item.keys,
			desc = table.concat(vim.tbl_keys(item.desc), " | "),
		})
	end

	return mini_clue
end

local function seq(prefix)
	local sequence = {}

	local meta = {
		__call = function(_, keys)
			return ("%s%s"):format(prefix, keys)
		end,
		__index = function(tbl, keys)
			return tbl(keys)
		end,
	}

	setmetatable(sequence, meta)

	return sequence
end

local function set(tbl, mode, keys, desc)
	for _, value in pairs(tbl._list) do
		if value.mode == mode and string.lower(value.keys) == string.lower(keys) then
			value.desc[desc] = true
			return
		end
	end

	local descriptions = {}
	descriptions[desc] = true
	table.insert(tbl._list, { mode = mode, keys = keys, desc = descriptions })

	return seq(keys)
end

local meta = {
	__call = function(tbl, mode, keys, desc)
		if type(mode) == "string" then
			mode = { mode }
		end

		for _, mod in pairs(mode) do
			set(tbl, mod, keys, desc)
		end

		return seq(keys)
	end,
}

return setmetatable(clue, meta)
