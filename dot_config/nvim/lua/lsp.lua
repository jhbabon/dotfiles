---Small LSP helpers
---@module 'lsp'
local lsp = {}

---Enable LSP clients and make sure they are attached to the current buffer
---@param names string|string[]
function lsp.enable(names)
	vim.schedule(function()
		-- Keep a reference to the current editorconfig settings
		local bufnr = vim.api.nvim_get_current_buf()
		local editorconfig = vim.b[bufnr].editorconfig

		-- Enable LSP clients
		vim.lsp.enable(names)

		-- This will retrigger FileType events, which in turn will
		-- trigger the events defined by vim.lsp. These events
		-- will ensure that the LSP server is initialized and attached
		-- to the current buffer
		vim.cmd([[filetype detect]])

		-- Reapply editorconfig settings in case the LSP server (like Rust) overrides them
		-- after calling "filetype detect"
		if editorconfig ~= nil then
			require("editorconfig").config(bufnr)
		end
	end)
end

return lsp
