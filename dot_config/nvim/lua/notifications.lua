local M = {}

local function around(block)
	local ok = true
	local result = nil

	local function yield(fn)
		ok, result = pcall(fn)
	end

	block(yield)

	if not ok then
		error(result)
	end

	return result
end

local suppressed = nil

-- Suppress a message from the notifications entirely
function M.suppress(msg, fn)
	return around(function(yield)
		suppressed = msg
		yield(fn)
		suppressed = nil
	end)
end

local redirected = {}

-- Redirect a message to a new level
function M.redirect(msg, level, fn)
	return around(function(yield)
		redirected = { msg, level }
		yield(fn)
		redirected = {}
	end)
end

-- Decorate a notify function so it respects the suppress and redirect helpers
function M.decorate(notify)
	return function(msg, level, options)
		if suppressed == msg then
			return
		end

		local lvl = level
		if redirected[1] == msg then
			lvl = redirected[2]
		end

		return notify(msg, lvl, options)
	end
end

return M
