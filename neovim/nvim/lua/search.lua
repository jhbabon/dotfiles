local h = require('helpers')

-- vim-grepper
h.exec([[let g:grepper = { 'tools': ['rg', 'git', 'grep'] }]])

h.nmap('<leader>sw', [[:Grepper -noprompt -cword<cr>]])
h.nmap('<leader>sq', [[:Grepper -query<space>]])
h.nmap('<leader>sc', ':nohl<cr>')

h.exec([[packadd! vim-grepper]])
