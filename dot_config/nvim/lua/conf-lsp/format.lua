return function()
	local notifications = require("notifications")
	local format_warning = "[LSP] Format request failed, no matching language servers."

	local function save_marks(bufnr)
		local marks = {}
		for _, m in pairs(vim.fn.getmarklist(bufnr)) do
			if m.mark:match("%a") then
				marks[m.mark] = m.pos
			end
		end
		return marks
	end

	local function restore_marks(marks, bufnr)
		-- no need to restore marks that still exist
		for _, m in pairs(vim.fn.getmarklist(bufnr)) do
			marks[m.mark] = nil
		end
		-- restore marks
		for mark, pos in pairs(marks) do
			if pos then
				vim.fn.setpos(mark, pos)
			end
		end
	end

	-- Execute formatting, but make sure marks are restored after doing it.
	-- @see https://github.com/jose-elias-alvarez/null-ls.nvim/pull/5/files
	local function format(bufnr)
		local marks = save_marks(bufnr)
		-- Redirect the default format warning message to debug level.
		-- It's quite noisy and I know there might be servers that can't format
		-- I don't need to see the message all the time
		notifications.redirect(format_warning, vim.log.levels.DEBUG, function()
			vim.lsp.buf.format({ bufnr = bufnr })
		end)
		restore_marks(marks, bufnr)
	end

	local formatters = {}
	local group = vim.api.nvim_create_augroup("lsp-format", { clear = true })
	vim.api.nvim_create_autocmd("LspAttach", {
		group = group,
		callback = function(args)
			local buffer = args.buf
			if formatters[buffer] then
				return
			end

			local id = vim.api.nvim_create_autocmd("BufWritePre", {
				group = group,
				buffer = buffer,
				callback = function()
					format(buffer)
				end,
			})
			formatters[buffer] = id
		end,
	})

	vim.api.nvim_create_autocmd("LspDetach", {
		group = group,
		callback = function(args)
			local buffer = args.buf
			local id = formatters[buffer]
			if id then
				formatters[buffer] = nil
				vim.api.nvim_del_autocmd(id)
			end
		end,
	})
end
