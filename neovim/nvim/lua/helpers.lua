local M = {}

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

function M.set(args)
  local option = args[1]
  local value = args[2]

  if value == nil then
    vim.cmd('set ' .. option)
  else
    vim.cmd('set ' .. option .. '=' .. value)
  end
end

return M
