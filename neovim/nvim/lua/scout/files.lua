local fmt = string.format
local config = require("scout.config").config
local core = require("scout.core")
local u = require("scout.utils")

local M = {}

local openers = {
  ["c-v"] = "vsplit",
  ["c-x"] = "split",
  ["c-t"] = "tab split",
  ["enter"] = "edit",
}

local function open(selection, signal)
  if u.is_present(selection) then
    local opener = openers[signal]
    assert(opener, fmt('unknown signal "%s"', signal))

    vim.cmd(fmt("%s %s", opener, selection))
  end
end

function M.run(options)
  local opts = vim.tbl_extend("force", config.files, options or {})

  core.run({
    search = opts.search,
    list_cmd = opts.finder,
    done = open,
    title = "files",
  })
end

return M
