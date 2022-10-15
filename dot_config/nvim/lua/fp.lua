--- Fp: functions over functions
---@module 'fp'
local fp = {}

--- Execute a function only once and return the same value on consecutive calls
---@param fn fun() any
function fp.once(fn)
	local executed = false
	local result = nil

	local meta = {}
	function meta.__call()
		if executed then
			return result
		end

		result = fn()
		executed = true

		return result
	end

	local proxy = {}
	setmetatable(proxy, meta)

	return proxy
end

return fp
