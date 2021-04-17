local h = require('helpers')

-- exit fast from insert mode
h.imap('jj', '<esc>')

h.nmap('<leader><space>', [[:lua require('scout.mappings').run({mode='n'})<cr>]], { silent = true, hint = 'maps: show mappings' })
h.map('v', '<leader><space>', [[:lua require('scout.mappings').run({mode='v'})<cr>]], {silent = true, hint = 'maps: show mappings'})

local strip = table.concat({
  [[:let _s=winsaveview()]],     -- save current cursor position
  [[:keeppatterns %s/\s\+$//e]], -- remove all trailing withespaces
  [[:call winrestview(_s)]],     -- restore cursor position
  [[<cr>]],                      -- execute all of the above
}, '<Bar>') -- join all with '|' in one line
h.nmap('<leader>u<space>', strip, { silent = true, hint = 'misc: remove trailing whitespace' })
h.nmap('<leader>u;', [[:s/\([^;]\)$/\1;/<cr>:noh<cr>]], { silent = true, hint = 'misc: add semicolon (;) at eol' })
h.nmap('<leader>u,', [[:s/\([^,]\)$/\1,/<cr>:noh<cr>]], { silent = true, hint = 'misc: add comma (,) at eol' })
