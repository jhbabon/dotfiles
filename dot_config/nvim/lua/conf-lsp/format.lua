return function()
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
		vim.lsp.buf.format()
		restore_marks(marks, bufnr)
	end

	local group = vim.api.nvim_create_augroup("lsp-format", { clear = true })
	local formatters = {}
	vim.api.nvim_create_autocmd("LspAttach", {
		group = group,
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)

			-- This autocmd runs before any on_attach defined in plugin/lsp/*.lua
			-- that means that removing the server capabilities won't work
			-- but we can initialize the server with the desired capabilities
			-- and recover them here through client.config.capabilites
			local formatting = client.server_capabilities.documentFormattingProvider
			if formatting
					and client.config
					and client.config.capabilites
					and client.config.capabilities.documentFormattingProvider ~= nil
			then
				-- Use the defined configuration
				formatting = client.config.capabilities.documentFormattingProvider
			end

			if not formatting then
				return
			end

			-- So, if the client is null-ls we need to make sure that the any of the sources
			-- can actually format the file. We have to do this because null-ls might attach
			-- to files with sources with no formatting (i.e: code_actions.gitsigns)
			-- but it will report the documentFormattingProvider capability as true, which
			-- is true, kind of, because it really depends on the current available source
			-- In any case, this checks ensures that there is at least one formatting source
			-- and if not, returns
			if client.name == "null-ls" then
				local methods = require("null-ls.methods")
				local sources = require("null-ls.sources")
				local available = sources.get_available(vim.bo.filetype, methods.internal.FORMATTING)
				-- There are no available sources to format, we can skip
				if next(available) == nil then
					return
				end
			end

			local id = vim.api.nvim_create_autocmd("BufWritePre", {
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
				vim.api.nvim_del_autocmd(id)
			end
		end,
	})
end
