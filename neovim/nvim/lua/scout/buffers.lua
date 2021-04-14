local fmt = string.format
local config = require('scout').config
local core = require('scout.core')

local M = {}

local openers = {
  ['c-v'] = 'vert sb',
  ['c-x'] = 'sb',
  ['c-t'] = 'tab sb',
  ['enter'] = 'b',
}

local function open(selection, signal)
  if core.is_present(selection) then
    local opener = openers[signal]
    assert(opener, fmt('unknown signal "%s"', signal))

    local buffer = string.match(selection, '%s*(%d+)')

    if core.is_present(buffer) then
      vim.cmd(fmt('%s %s', opener, buffer))
    end
  end
end

function M.run(options)
  local opts = options or {}
  local tmpfile = core.tmpfile()
  local list = vim.api.nvim_exec('ls', true)
  tmpfile.write(list)

  local list_cmd = fmt('cat %s', tmpfile.name)
 s
  core.run({
    list_cmd = list_cmd,
    action = open,
    search = opts.search,
    finish = tmpfile.close,
  })
end

return M
