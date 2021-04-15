local h = require('helpers')

-- nvim-projectconfig
require('nvim-projectconfig').load_project_config()
h.nmap('<leader>pe', [[<cmd>lua require('nvim-projectconfig').edit_project_config()<cr>]], { silent = true })

-- vim-projectionist
function projectionist_rspec(input, ...)
  local _, name = string.match(input, [[.*Spec::(%w+)::(.+)$]])

  return name
end

local heuristics = vim.fn.json_encode{
  ["Gemfile|*.gemspec"] = {
    ["*_spec.rb"] = {
      type = "spec",
      template = {
        "require 'spec_helper'",
        "",
        "describe {camelcase|capitalize|colons|rspec} do",
        "end",
      }
    }
  }
}

h.multi_exec {
  string.format('let g:projectionist_heuristics = %s', heuristics),
  [[let g:projectionist_transformations = {}]],
  [[let g:projectionist_transformations.rspec = {i -> v:lua.projectionist_rspec(i)}]],
  [[packadd! vim-projectionist]]
}
