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

return M
