return function()
  vim.g.projectionist_heuristics = {
    ["Gemfile|*.gemspec"] = {
      ["*_spec.rb"] = {
        type = "spec",
        template = {
          "require 'spec_helper'",
          "",
          "describe {camelcase|capitalize|colons|rspec} do",
          "end",
        },
      },
    },
  }

  local utils = require("utils")
  -- the transformation has to be set as a vim lambda, hence the exec command
  utils.multi_exec({
    [[let g:projectionist_transformations = {}]],
    [[let g:projectionist_transformations.rspec = {i -> v:lua.require("projectionist-transformers").rspec(i)}]],
  })
end
