-- minimap.vim
vim.g.minimap_close_filetypes = {'startify', 'netrw', 'vim-plug', 'fugitive', 'git', 'which_key', 'lspinfo'}
vim.cmd [[packadd! minimap.vim]]

local keymap = {}
keymap.m = {
  name = '+minimap',
  t = {':MinimapToggle<cr>', 'toggle'},
  r = {':MinimapRefresh<cr>', 'refresh'},
}
require('whichkey_setup').register_keymap('leader', keymap)
