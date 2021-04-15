local h = require('helpers')

-- exit fast from insert mode
h.imap('jj', '<esc>')

-- TODO: make this work
h.nmap('<leader><space>', [[:lua require('scout.mappings').run()<cr>]], {silent = true})

local strip = table.concat({
  [[:let _s=winsaveview()]],     -- save current cursor position
  [[:keeppatterns %s/\s\+$//e]], -- remove all trailing withespaces
  [[:call winrestview(_s)]],     -- restore cursor position
  [[<cr>]],                      -- execute all of the above
}, '<Bar>') -- join all with '|' in one line
h.nmap('<leader>u<space>', strip, { silent = true })
h.nmap('<leader>u;', [[:s/\([^;]\)$/\1;/<cr>:noh<cr>]], { silent = true })
h.nmap('<leader>u,', [[:s/\([^,]\)$/\1,/<cr>:noh<cr>]], { silent = true })
