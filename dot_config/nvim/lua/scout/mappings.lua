-- Experimental module that shows the current defined mappings inside vim
-- It uses a function, "hints", that returns a hint associated to a keymap
-- This function has to be passed as a dependency.
--
-- The idea is to use the list and selection as a cheatsheet.
-- When selecting a mapping, it will be executed.
--
-- @see keychain.hints
local fmt = string.format
-- TODO: Try to inject this dependency
local u = require("scout.utils")
local core = require("scout.core")

local M = {}

local function encode(raw, hints)
  local m, lhs, rhs = string.match(raw, "(%S+)%s+(%S+)%s+(.*)")

  local hint = nil
  if u.is_present(m) then
    hint = hints(m, lhs)
  end

  if u.is_present(hint) then
    rhs = hint
  end

  return fmt("%-10s  %s", lhs, rhs)
end

local function decode(enc)
  return string.match(enc, "(%S+)%s+.*") or ""
end

local function build_list(mode, hints)
  local map = fmt("%smap", mode or "")
  local raw = vim.api.nvim_exec(map, true)

  local list = {}
  for line in raw:gmatch("([^\n]*)\n?") do
    if u.is_present(line) then
      table.insert(list, encode(line, hints))
    end
  end

  return list
end

local function open(selection, _)
  if u.is_present(selection) then
    local keys = decode(selection)
    vim.fn.feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true))
  end
end

local function none()
  return nil
end

function M.run(options)
  local opts = options or { mode = "n", hints = none }
  assert(opts.mode, 'the option "mode" is missing')
  assert(opts.hints, 'the option "hints" is missing')
  local list = build_list(opts.mode, opts.hints)

  core.run({
    search = opts.search,
    list = list,
    done = open,
    title = "mappings",
  })
end

return M
