-- Experimental module that shows the current defined mappings inside vim
-- It uses the module "utils" that associates hints, or descriptions, to
-- each map so it's easier to know what does each mapping
-- @see utils
--
-- The idea is to use the list and selection as a cheatsheet.
-- When selecting a mapping, it will be executed.
local fmt = string.format
-- TODO: Try to inject this dependency
local h = require("utils")
local u = require("scout.utils")
local core = require("scout.core")

local M = {}

local function encode(raw)
  local m, lhs, rhs = string.match(raw, "(%S+)%s+(%S+)%s+(.*)")
  local hint = h.map_hint(m, lhs)
  if u.is_present(hint) then
    rhs = hint
  end

  return fmt("%-10s  %s", lhs, rhs)
end

local function decode(enc)
  return string.match(enc, "(%S+)%s+.*") or ""
end

local function build_list(mode)
  local map = fmt("%smap", mode or "")
  local raw = vim.api.nvim_exec(map, true)

  local list = {}
  for line in raw:gmatch("([^\n]*)\n?") do
    if u.is_present(line) then
      table.insert(list, encode(line))
    end
  end

  return list
end

local function open(selection, _)
  if u.is_present(selection) then
    local keys = decode(selection)
    vim.fn.feedkeys(h.expr_quote(keys))
  end
end

function M.run(options)
  local opts = options or { mode = "n" }
  assert(opts.mode, 'the option "mode" is missing')
  local list = build_list(opts.mode)

  core.run({
    search = opts.search,
    list = list,
    done = open,
    title = "mappings",
  })
end

return M
