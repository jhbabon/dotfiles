-- Jump to a symbol in the current file using aerial.nvim info
local core = require("scout.core")
local u = require("scout.utils")
local aerial = require("aerial.fzf")

local M = {}

function M.run(options)
  local opts = options or {}

  core.run({
    search = opts.search,
    list = aerial.get_labels(),
    done = function(selection, _)
      if u.is_empty(selection) then
        return
      end

      aerial.goto_symbol(selection)
    end,
    title = "document symbols",
  })
end

return M
