local M = {}

-- Default values
M.config = {
  cmd = "scout",
  files = {
    finder = "find * -type f",
  },
}

function M.setup(cfg)
  M.config = vim.tbl_extend("force", M.config, cfg)
end

return M
