local fmt = string.format
local config = require('scout').config
local u = require('scout.utils')
local core = require('scout.core')

local M = {}

local function expr_quote(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function open(selection, signal)
  if u.is_present(selection) then
    chunks = {}
    for substring in selection:gmatch("%S+") do
      table.insert(chunks, substring)
    end
    local keys = chunks[2]
    vim.fn.feedkeys(expr_quote(keys))
  end
end

-- TODO: filter by mode
-- TODO: replace rhs (mapping destination) with text from a table/function
function M.run(options)
  local opts = options or {}
  local list = vim.api.nvim_exec('map', true)

  core.run({
    search = opts.search,
    list = list,
    done = open,
    title = 'mappings',
  })
end

return M
