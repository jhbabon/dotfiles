-- -----------------------------------------------------------------------
--
-- Utils: functions to set up VIM settings, mappings and execute VIM code
-- -----------------------------------------------------------------------

local fmt = string.format
local M = {}

function M.expr_quote(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local hints = {}
local escape = {
  __index = function(t, key)
    local esc = M.expr_quote(key)
    return rawget(t, esc)
  end,
  __newindex = function(t, key, value)
    local esc = M.expr_quote(key)
    rawset(t, esc, value)
  end
}
local modes = {
  __index = function(t, key)
    local m = {}
    setmetatable(m, escape)
    t[key] = m
    return m
  end
}
setmetatable(hints, modes)

local function format_set(args)
  local option = args[1]
  local value = args[2]
  local template = 'set %s'

  if value ~= nil then
    template = 'set %s=%s'
  end

  return fmt(template, option, value)
end

function M.exec(command)
  vim.api.nvim_exec(command, false)
end

-- multi exec: execute multiple exec commands at once
function M.multi_exec(commands)
  M.exec(table.concat(commands, "\n"))
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

  M.multi_exec(sets)
end

local function map_options(mode, lhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end

  hints[mode][lhs] = options.hint
  options.hint = nil

  return options
end

function M.map_buf(bufnr, mode, lhs, rhs, opts)
  local options = map_options(mode, lhs, opts)

  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

function M.nmap_buf(bufnr, ...)
  M.map_buf(bufnr, 'n', ...)
end

function M.map(mode, lhs, rhs, opts)
  local options = map_options(mode, lhs, opts)

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.imap(...)
  M.map('i', ...)
end

function M.nmap(...)
  M.map('n', ...)
end

function M.map_hint(mode, lhs)
  return hints[mode][lhs]
end

return M
