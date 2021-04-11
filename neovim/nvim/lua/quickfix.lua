local keymap = {}
keymap.q = {
  name = '+quickfix',
  n = {':cn<cr>', 'next'},
  p = {':cp<cr>', 'previous'},
}
require('whichkey_setup').register_keymap('leader', keymap)
