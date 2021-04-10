-- Colorscheme
vim.cmd('syntax on')
vim.cmd('syntax reset')
vim.o.termguicolors = true
require('base16-colorscheme').setup('material-palenight')
