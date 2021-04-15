local h = require('helpers')

-- minimap.vim
vim.g.minimap_close_filetypes = {'startify', 'netrw', 'vim-plug', 'fugitive', 'git', 'which_key', 'lspinfo'}
vim.cmd [[packadd! minimap.vim]]

h.nmap('<leader>mt', ':MinimapToggle<cr>', { silent = true })
h.nmap('<leader>mr', ':MinimapRefresh<cr>', { silent = true })
