---Configure bqf plugin: kevinhwang91/nvim-bqf
-- Better quickfix window in Neovim, polish old quickfix window.
-----------------------------------------------------------------------
if vim.g.__bqf_plugin__ then
	return
end
vim.g.__bqf_plugin__ = true

require("defer").offload(function()
	require("bqf").setup({})

	require("clue")("n", "<leader>q", "quicklist")
	vim.keymap.set("n", "<leader>qt", function()
		for _, win in pairs(vim.fn.getwininfo()) do
			if win["quickfix"] == 1 then
				vim.cmd([[cclose]])
				return
			end
		end

		if not vim.tbl_isempty(vim.fn.getqflist()) then
			vim.cmd([[copen]])
		end
	end, { desc = "toggle quicklist" })

	vim.keymap.set("n", "<leader>ql", function()
		for _, win in pairs(vim.fn.getwininfo()) do
			if win["loclist"] == 1 then
				vim.cmd([[lclose]])
				return
			end
		end

		if not vim.tbl_isempty(vim.fn.getloclist(0)) then
			vim.cmd([[lopen]])
			return
		end
	end, { desc = "toggle location list" })
end)
