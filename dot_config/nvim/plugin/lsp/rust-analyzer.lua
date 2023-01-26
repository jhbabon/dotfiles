if vim.g.mylsp_rust_analyzer_loaded then
	return
end
vim.g.mylsp_rust_analyzer_loaded = true

local option = require("option")
local binaries = require("binaries")

-- Try to use rust-analyzer if is present in rustup toolchain
local function rustup(_)
	if vim.fn.executable("rustup") == 0 then
		return option.none()
	end

	-- TODO: Use jobs?
	if vim.fn.system("rustup which rust-analyzer"):match("error: ") then
		return option.none()
	end

	-- TODO: Try to get current toolchain?
	return option.some({ "rustup", "run", "stable", "rust-analyzer" })
end

require("conf-lsp.server").setup({
	name = "rust_analyzer",
	pattern = { "rust" },
	bin = {
		spec = { name = "rust-analyzer" },
		lookups = { rustup, binaries.lookups.mason },
	},
	hook = function(_)
		return {
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
	end,
})
