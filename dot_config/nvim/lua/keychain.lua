--- Utility funtions around keymaps and support for hints for these keymaps
-- @module keychain
local keychain = {}

-- imports
local format = string.format

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
  if not hint then
    return
  end

  if type(mode) == "string" then
    mode = { mode }
  end

  for _, m in pairs(mode) do
    hints[m][lhs] = hint
  end
end

local function del_hint(mode, lhs)
  if type(mode) == "string" then
    mode = { mode }
  end

  for _, m in pairs(mode) do
    hints[m][lhs] = nil
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

--- Wrapper around vim.keymap.set. It accepts the extra option hint.
--- Pass the option hint = { "label", "description" } to set a description of the keymap
function keychain.set(mode, lhs, rhs, opts)
  local options, hint = map_options(opts)

  set_hint(mode, lhs, hint)

  vim.keymap.set(mode, lhs, rhs, options)
end

function keychain.del(mode, lhs, opts)
  del_hint(mode, lhs)

  vim.keymap.del(mode, lhs, opts)
end

--- Add keymap, alias of #set
function keychain.map(mode, lhs, rhs, opts)
  keychain.set(mode, lhs, rhs, opts)
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

--- Add keymap to buffer
function keychain.map_buf(bufnr, mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", opts, { buffer = bufnr })
  keychain.map(mode, lhs, rhs, opts)
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

--- Get the hint associated to a keymap and mode
-- @tparam string mode one of vim's modes (e.g: v, i, n, etc)
-- @tparam string lhs the left hand side of the keymap
-- @treturn[1] string the hint
-- @treturn[2] nil if there is no hint available
function keychain.hint(mode, lhs)
  return hints[mode][lhs]
end

return keychain
