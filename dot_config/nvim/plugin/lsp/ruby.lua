---Configure sorbet and efm for ruby files
-----------------------------------------------------------------------
if vim.g.__lsp_ruby_plugin__ then
	return
end
vim.g.__lsp_ruby_plugin__ = true

local layers = require("layers")

layers.set("lsp.ruby.sorbet", function()
	local function srb(_)
		return require("execs.scopes"):map(function(cmd)
			return { cmd[1], "tc", "--lsp" }
		end)
	end

	require("lazy-lsp").sorbet.setup({ pattern = { "ruby" } }, function(exec)
		return {
			cmd = exec({ "srb", scopes = { srb } }).cmd,
		}
	end)
end)

layers.set("lsp.ruby.efm", function()
	require("lazy-lsp").efm.setup({ pattern = { "ruby" } }, function(exec)
		local rubocop = ("%s --format emacs --stdin ${INPUT}"):format(
			exec({ "rubocop", scopes = { require("execs.scopes").local_bin } })
		)

		return {
			settings = {
				rootMarkers = { ".git/" },
				languages = {
					ruby = {
						{
							prefix = "rubocop",
							lintCommand = rubocop,
							lintStdin = true,
							lintFormats = { "%f:%l:%c: %t: %m" },
							rootMarkers = {},
						},
					},
				},
			},
		}
	end)
end)
