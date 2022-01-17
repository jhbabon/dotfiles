--- Utility funtions around keymaps and support for hints for these keymaps
-- @module keychain
local keychain = {}

-- imports
local format = string.format

-- curry/partial application of the first argument of a function
local function curry(fn, ...)
  local args = { ... }
  return function(...)
    return fn(unpack(args), ...)
  end
end

local function escape_str(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- collect hints associated to the lhs (left hand side) of keymaps, by mode
local hints = {}
-- clean escape sequences from any key
local escape = {
  __index = function(t, key)
    local esc = escape_str(key)
    return rawget(t, esc)
  end,
  __newindex = function(t, key, value)
    local esc = escape_str(key)
    rawset(t, esc, value)
  end,
}
local modes = {
  __index = function(t, key)
    local m = {}
    setmetatable(m, escape)
    t[key] = m
    return m
  end,
}
setmetatable(hints, modes)

local function set_hint(mode, lhs, hint)
  if hint then
    hints[mode][lhs] = hint
  end
end

local function map_options(opts)
  -- default options
  local hint = nil
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  -- hints are in the form: { "label", "description" }
  if options.hint then
    hint = format("%s -> %s", unpack(options.hint))
    options.hint = nil
  end

  return options, hint
end

local function _map(mode, lhs, rhs, opts, mapper)
  local options, hint = map_options(opts)

  set_hint(mode, lhs, hint)
  mapper(mode, lhs, rhs, options)
end

--- Add keymap to buffer
-- Pass the option hint = { "label", "description" } to set a description of the keymap
function keychain.map_buf(bufnr, mode, lhs, rhs, opts)
  _map(mode, lhs, rhs, opts, curry(vim.api.nvim_buf_set_keymap, bufnr))
end

function keychain.imap_buf(bufnr, ...)
  return keychain.map_buf(bufnr, "i", ...)
end

function keychain.nmap_buf(bufnr, ...)
  return keychain.map_buf(bufnr, "n", ...)
end

function keychain.vmap_buf(bufnr, ...)
  return keychain.map_buf(bufnr, "v", ...)
end

--- Add keymap
function keychain.map(mode, lhs, rhs, opts)
  _map(mode, lhs, rhs, opts, vim.api.nvim_set_keymap)
end

function keychain.nmap(...)
  return keychain.map("n", ...)
end

function keychain.imap(...)
  return keychain.map("i", ...)
end

function keychain.vmap(...)
  return keychain.map("v", ...)
end

--- Get the hint associated to a keymap and mode
-- @tparam string mode one of vim's modes (e.g: v, i, n, etc)
-- @tparam string lhs the left hand side of the keymap
-- @treturn[1] string the hint
-- @treturn[2] nil if there is no hint available
function keychain.hint(mode, lhs)
  return hints[mode][lhs]
end

return keychain
