-- minimap.vim
vim.g.minimap_close_filetypes = {'startify', 'netrw', 'vim-plug', 'fugitive', 'git', 'which_key'}
vim.g.minimap_auto_start = true
vim.g.minimap_auto_start_win_enter = true
vim.cmd [[packadd! minimap.vim]]
