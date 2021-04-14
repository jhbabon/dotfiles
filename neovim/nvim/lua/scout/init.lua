-- TODO: add buffers management
-- TODO: add mappings management (?)

local M = {}
-- Default values
M.config = {
  cmd = 'scout',
  files = {
    finder = 'find * -type f',
  },
}

function M.setup(conf)
  -- TODO: validation ?
  M.config = vim.tbl_extend('force', M.config, conf)
end

return M
