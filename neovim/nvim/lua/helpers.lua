local fmt = string.format
local M = {}

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

-- Execute multiple exec commands at once
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

local function map_options(opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end

  return options
end

function M.map_buf(bufnr, mode, lhs, rhs, opts)
  local options = map_options(opts)

  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

function M.nmap_buf(bufnr, ...)
  M.map_buf(bufnr, 'n', ...)
end

function M.map(mode, lhs, rhs, opts)
  local options = map_options(opts)

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.imap(...)
  M.map('i', ...)
end

function M.nmap(...)
  M.map('n', ...)
end

return M
