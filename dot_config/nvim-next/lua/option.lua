-- Bring Rust's Option enum to lua, more or less
---@module 'option'

local option = {}

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

	return some
end

function option.wrap_some(fn)
	return function(opt)
		return opt:and_then(fn)
	end
end

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

	return none
end

function option.wrap_none(fn)
	return function(opt)
		return opt:or_else(fn)
	end
end

return option
