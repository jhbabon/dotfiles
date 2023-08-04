-- "fun" for "functional", get it?

local fun = {}

-- tap into a value, do something with it, and return it
function fun.tap(value, fn)
	fn(value)
	return value
end


return fun
