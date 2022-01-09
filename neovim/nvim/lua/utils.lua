-- -----------------------------------------------------------------------
--
-- Utils: functions to set mappings and execute VIM code
-- -----------------------------------------------------------------------
-- local fmt = string.format
local utils = {}

function utils.exec(command)
  vim.api.nvim_exec(command, false)
end

-- multi exec: execute multiple exec commands at once
function utils.multi_exec(commands)
  utils.exec(table.concat(commands, "\n"))
end

-- Define sets of augroups
-- @example
--   local utils = require("utils")
--   utils.augroups({
--     augroup_name = {
--       -- autocmd
--       { "FileType", "lua", "lua print("lua file") },
--     }
--   })
function utils.augroups(definitions)
  local cmds = {}
  for group_name, definition in pairs(definitions) do
    table.insert(cmds, "augroup " .. group_name)
    table.insert(cmds, "autocmd!")

    for _, def in pairs(definition) do
      local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
      table.insert(cmds, command)
    end

    table.insert(cmds, "augroup END")
  end

  utils.multi_exec(cmds)
end

return utils
