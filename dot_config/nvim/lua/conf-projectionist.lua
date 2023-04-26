return function()
	vim.g.projectionist_heuristics = {
		["Gemfile|*.gemspec"] = {
			["*_spec.rb"] = {
				type = "spec",
				template = {
					"require 'spec_helper'",
					"",
					"RSpec.describe {camelcase|capitalize|colons|rspec} do",
					"end",
				},
			},
		},
	}

	-- the transformation has to be set as a vim lambda, hence the exec command
	vim.api.nvim_exec2(
		[[
		let g:projectionist_transformations = {}
		let g:projectionist_transformations.rspec = {i -> v:lua.require("projectionist-transformers").rspec(i)}
	]],
		{ output = false }
	)
end
