if vim.g.__completion_plugin__ then
	return true
end
vim.g.__completion_plugin__ = true

require("defer").offload(function()
	require("mini.completion").setup({
		lsp_completion = {
			source_func = "completefunc",
			auto_setup = false,
		},
	})

	local group = vim.api.nvim_create_augroup("lsp-autocomplete", { clear = true })
	vim.api.nvim_create_autocmd("LspAttach", {
		group = group,
		callback = function()
			vim.opt_local.completefunc = "v:lua.MiniCompletion.completefunc_lsp"
		end,
	})
end)
