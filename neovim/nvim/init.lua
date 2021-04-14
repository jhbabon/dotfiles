require('settings')
require('packages')

vim.cmd('filetype off')

require('scout') -- experiment

require('treesitter')
require('lsp')
require('git')
require('minimap')
require('autopairs')
require('comments')
require('quickfix')
require('files')
require('projects')

require('statusline')
require('colorscheme')

vim.cmd('filetype plugin indent on')

require('mappings')
