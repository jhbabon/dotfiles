require('settings')
require('packages')

vim.cmd('filetype off')

require('treesitter')
require('lsp')
require('git')
require('minimap')
require('autopairs')
require('comments')
require('quickfix')
require('files')

require('colorscheme')

vim.cmd('filetype plugin indent on')

require('mappings')
