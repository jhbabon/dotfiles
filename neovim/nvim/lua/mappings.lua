local h = require('helpers')

-- exit fast from insert mode
h.imap('jj', '<esc>')

local keymap = {}
local strip = table.concat({
  [[:let _s=winsaveview()]],     -- save current cursor position
  [[:keeppatterns %s/\s\+$//e]], -- remove all trailing withespaces
  [[:call winrestview(_s)]],     -- restore cursor position
  [[<cr>]],                      -- execute all of the above
}, '<Bar>') -- join all with '|' in one line
keymap.m = {
  name = '+misc',
  [' '] = {strip, 'strip all trailing whitespaces'},
  [';'] = {[[:s/\([^;]\)$/\1;/<cr>:noh<cr>]], 'add semicolon at eol'},
  [','] = {[[:s/\([^,]\)$/\1,/<cr>:noh<cr>]], 'add comma at eol'},
}

require('whichkey_setup').register_keymap('leader', keymap)
