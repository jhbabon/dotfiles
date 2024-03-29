---Configure rust-analyzer for rust files
-----------------------------------------------------------------------
if vim.g.__lsp_rust_plugin__ then
	return
end
vim.g.__lsp_rust_plugin__ = true

require("layers").set("lsp.rust.rust-analyzer", function()
	local option = require("option")
	local scopes = require("execs.scopes")

	-- Try to use rust-analyzer if is present in rustup toolchain
	local function rustup(_)
		if vim.fn.executable("rustup") == 0 then
			return option.none()
		end

		if vim.fn.system("rustup which rust-analyzer"):match("error: ") then
			return option.none()
		end

		-- TODO: Try to get current toolchain?
		return option.some({ "rustup", "run", "stable", "rust-analyzer" })
	end

	require("lazy-lsp").rust_analyzer.setup({ pattern = { "rust" } }, function(exec)
		local spec = {
			"rust-analyzer",
			scopes = { rustup, scopes.system, scopes.mason },
		}
		return {
			cmd = exec(spec).cmd,
			settings = {
				-- to enable rust-analyzer settings visit:
				-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
				["rust-analyzer"] = {
					-- enable clippy on save
					checkOnSave = {
						command = "clippy",
					},
				},
			},
		}
	end)
end)
