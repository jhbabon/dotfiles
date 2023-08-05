---Bring Rust's Option enum to lua, more or less
---@module 'option'

---@alias T any
---@alias R any

---@class Option<T>
---@field is_some fun(): boolean
---@field is_none fun(): boolean
---@field unwrap fun(): nil|any
---@field _and fun(opt: Option<T>): Option<T>
---@field _or fun(opt: Option<T>): Option<T>
---@field and_then fun(callback: fun(value: any): Option<T>): Option<T>
---@field or_else fun(callback: fun(): Option<T>): Option<T>
---@field map fun(fn: fun(value: T): R): Option<R>

local option = {}

---@param val any
---@return Option<any> Some(val)
function option.some(val)
	local some = {
		__val = val,
	}

	function some:is_some()
		return true
	end

	function some:is_none()
		return false
	end

	function some:unwrap()
		return self.__val
	end

	function some:_and(opt)
		return opt
	end

	function some:_or(_)
		return self
	end

	function some:and_then(fn)
		return fn(self.__val)
	end

	function some:or_else(_)
		return self
	end

	function some:map(fn)
		return option.some(fn(self.__val))
	end

	return some
end

function option.wrap_some(fn)
	return function(opt)
		return opt:and_then(fn)
	end
end

---@return Option<any> None
function option.none()
	local none = {}

	function none:is_some()
		return false
	end

	function none:is_none()
		return true
	end

	function none:unwrap(_)
		-- Return error?
		return nil
	end

	function none:_and(_)
		return self
	end

	function none:_or(opt)
		return opt
	end

	function none:and_then(_)
		return self
	end

	function none:or_else(fn)
		return fn()
	end

	function none:map(_)
		return self
	end

	return none
end

function option.wrap_none(fn)
	return function(opt)
		return opt:or_else(fn)
	end
end

return option
