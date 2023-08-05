if vim.g.__lsp_ruby_plugin__ then
	return
end
vim.g.__lsp_ruby_plugin__ = true

local lazy_lsp = require("lazy-lsp")
local scopes = require("execs.scopes")

local function local_bin(name)
	return scopes.system(("bin/%s"):format(name))
end

local function srb(_)
	return local_bin("srb"):map(function(cmd)
		return { cmd[1], "tc", "--lsp" }
	end)
end

lazy_lsp.sorbet.setup({ pattern = { "ruby" } }, function(exec)
	return {
		cmd = exec({ "srb", scopes = { srb } }).cmd,
	}
end)

lazy_lsp.efm.setup({ pattern = { "ruby" } }, function(exec)
	local rubocop = ("%s --lint --format emacs --stdin ${INPUT}"):format(exec({ "rubocop", scopes = { local_bin } }))

	return {
		settings = {
			rootMarkers = { ".git/" },
			languages = {
				ruby = {
					prefix = "rubocop",
					lintCommand = rubocop,
					lintStdin = true,
					lintFormats = { "%f:%l:%c: %t: %m" },
					rootMarkers = {},
				},
			},
		},
	}
end)
