local M = {}

function M.is_empty(s)
  return s == nil or s == ''
end

function M.is_present(s)
  return not M.is_empty(s)
end

return M
