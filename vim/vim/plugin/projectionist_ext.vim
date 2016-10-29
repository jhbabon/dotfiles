" Projectionist
if !exists('g:projectionist_transformations')
  let g:projectionist_transformations = {}
endif

" Custom transformations

" rspec
"
" Use it to generate the correct name of the module in the spec
" Is intended to be used after camelcase and colons
"
" @example
"   Given the template
"   describe {camelcase|colons|rspec} do
"
"   Input => describe engines/spec/lib/fancy/awesome do
"   Output => describe Fancy::Awesome do
function! g:projectionist_transformations.rspec(input, o) abort
  return substitute(a:input, '.*Spec::\(\w\+\)::\(.\+\)$', '\2', 'g')
endfunction

let g:projectionist_heuristics = {
      \   "Gemfile|*.gemspec": {
      \     "*_spec.rb": {
      \       "dispatch": "bundle exec rspec {file}",
      \       "type": "spec",
      \       "template": [
      \         "require 'spec_helper'",
      \         "",
      \         "describe {camelcase|colons|rspec} do",
      \         "end"
      \       ]
      \     }
      \   }
      \ }
