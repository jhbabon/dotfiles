return function()
	require("lazy").load(function()
		require("mini.completion").setup({
			lsp_completion = {
				source_func = "completefunc",
				auto_setup = false,
				process_items = function(items, base)
					local res = vim.tbl_filter(function(item)
						-- Keep items which match the base and ALSO snippets
						local word = (item.textEdit and item.textEdit.newText) or item.insertText or item.label or ""
						return vim.startswith(word, base)
					end, items)

					table.sort(res, function(a, b)
						return (a.sortText or a.label) < (b.sortText or b.label)
					end)

					return res
				end,
			},
		})

		local group = vim.api.nvim_create_augroup("lsp-autocomplete", { clear = true })
		vim.api.nvim_create_autocmd("LspAttach", {
			group = group,
			callback = function()
				vim.opt_local.completefunc = "v:lua.MiniCompletion.completefunc_lsp"
			end,
		})
		vim.api.nvim_create_autocmd("LspDetach", {
			group = group,
			callback = function()
				vim.opt_local.completefunc = nil
			end,
		})
	end)
end
