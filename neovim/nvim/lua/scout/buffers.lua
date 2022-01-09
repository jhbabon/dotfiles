-- List and select current buffers
local fmt = string.format
local u = require("scout.utils")
local core = require("scout.core")

local M = {}

local openers = {
  ["c-v"] = "vert sb",
  ["c-x"] = "sb",
  ["c-t"] = "tab sb",
  ["enter"] = "b",
}

local function open(selection, signal)
  if u.is_present(selection) then
    local opener = openers[signal]
    assert(opener, fmt('unknown signal "%s"', signal))

    local buffer = string.match(selection, "%s*(%d+)")

    if u.is_present(buffer) then
      vim.cmd(fmt("%s %s", opener, buffer))
    end
  end
end

function M.run(options)
  local opts = options or {}
  -- get current list of buffers
  local list = vim.api.nvim_exec("ls", true)

  core.run({
    search = opts.search,
    list = list,
    done = open,
    title = "buffers",
  })
end

return M
