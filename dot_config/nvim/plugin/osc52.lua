---Enable copying text through OSC52
-----------------------------------------------------------------------
if vim.g.__osc52_plugin__ then
	return true
end
vim.g.__osc52_plugin__ = true

require("defer").very_lazy(function()
	local group_name = "__osc52_plugin__"
	local function enable()
		local group = vim.api.nvim_create_augroup(group_name, { clear = true })
		local copy = require("vim.ui.clipboard.osc52").copy("+")
		vim.api.nvim_create_autocmd("TextYankPost", {
			group = group,
			pattern = { "*" },
			callback = function(_)
				copy(vim.v.event.regcontents)
			end,
		})
	end
	local function disable()
		vim.api.nvim_del_augroup_by_name(group_name)
	end

	local clue = require("clue")
	local _o = clue("n", "<leader>o", "Copy with OSC52")
	vim.keymap.set("n", _o.e, enable, { desc = "enable OSC52 copy" })
	vim.keymap.set("n", _o.d, disable, { desc = "disable OSC52 copy" })
end)
