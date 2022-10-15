--- Fp: functions over functions
---@module 'fp'
local fp = {}

--- Execute a function only once and return the same value on consecutive calls
---@param fn fun() any
function fp.once(fn)
	local executed = false
	local result = nil

	local function proxy()
		if executed then
			return result
		end

		result = fn()
		executed = true

		return result
	end

	return proxy
end

return fp
