local M = {}

local function format_set(args)
  local option = args[1]
  local value = args[2]

  local setter = 'set ' .. option

  if value ~= nil then
    setter = setter .. '=' .. value
  end

  return setter
end

function M.set(args)
  vim.cmd(format_set(args))
end

-- multi set: execute multiple set commands at once
function M.mset(options)
  local sets = {}
  for i, option in ipairs(options) do
    sets[i] = format_set(option)
  end

  local bulk = table.concat(sets, "\n")
  vim.api.nvim_exec(bulk, false)
end

function M.map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.imap(...)
  M.map('i', ...)
end

function M.nmap(...)
  M.map('n', ...)
end

return M
