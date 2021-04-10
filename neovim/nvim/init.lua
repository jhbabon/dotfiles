require('settings')
require('packages')

vim.cmd('filetype off')

require('treesitter')
require('fugitive')
require('minimap')

require('colorscheme')

vim.cmd('filetype plugin indent on')

require('mappings')
