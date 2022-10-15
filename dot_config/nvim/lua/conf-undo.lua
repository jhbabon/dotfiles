return function()
	require("lazy").load(function()
		local setup = require("fp").once(function()
			vim.cmd.packadd("undotree")
			require("undotree").setup()
		end)

		local function toggle()
			setup()

			require("undotree").toggle()
		end

		require("keychain").set("n", "<leader>ut", toggle, { hint = { "undo", "toggle undo tree" } })
	end)
end
