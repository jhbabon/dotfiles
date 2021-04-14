local fmt = string.format
local config = require('scout').config
local core = require('scout.core')

local M = {}

local openers = {
  ['c-v'] = 'vsplit',
  ['c-x'] = 'split',
  ['c-t'] = 'tab split',
  ['enter'] = 'edit',
}

local function open(selection, signal)
  if core.is_present(selection) then
    local opener = openers[signal]
    assert(opener, fmt('unknown signal "%s"', signal))

    vim.cmd(fmt('%s %s', opener, selection))
  end
end

function M.run(options)
  local opts = vim.tbl_extend('force', config.files, options or {})

  core.run({ list_cmd = opts.finder, action = open, search = opts.search })
end

return M
