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
  if signal == 'exit' then
    return
  end

  if not core.isempty(selection) then
    local opener = openers[signal]
    assert(opener, fmt('failed to open with signal %s', signal))

    vim.cmd(fmt('%s %s', opener, selection))
  end
end

-- TODO: Accept search term
function M.run(search)
  local finder = config.files.finder

  core.run({ list_cmd = finder, finish = open, search = search })
end

return M
