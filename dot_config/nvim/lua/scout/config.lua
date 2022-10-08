local M = {}

-- Default values
M.config = {
	cmd = "scout",
	files = {
		finder = "find * -type f",
	},
	temp_dir = vim.fn.stdpath("cache"),
}

function M.setup(cfg)
	M.config = vim.tbl_extend("force", M.config, cfg)
end

return M
