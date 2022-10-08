--- Extra projectionist transformers
-- @module transformers
local transformers = {}

function transformers.rspec(input)
	return vim.fn.substitute(input, [[.*Spec::\(\w\+\)::\(.\+\)$]], [[\2]], "g")
end

return transformers
