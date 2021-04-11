local multi_exec = require('helpers').multi_exec
local keymap = {}

-- nvim-projectconfig
require('nvim-projectconfig').load_project_config()
keymap.p = {
  name = '+project',
  e = {[[<cmd>lua require('nvim-projectconfig').edit_project_config()<cr>]], 'edit project config'},
}

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

multi_exec {
  table.concat({'let g:projectionist_heuristics', heuristics}, '='),
  [[let g:projectionist_transformations = {}]],
  [[let g:projectionist_transformations.rspec = {i -> v:lua.projectionist_rspec(i)}]],
  [[packadd! vim-projectionist]]
}

require('whichkey_setup').register_keymap('leader', keymap)
