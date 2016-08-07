" Dispatch
autocmd FileType ruby let b:dispatch = '/usr/bin/env ruby %'
autocmd FileType rust let b:dispatch = 'cargo build'

" Mappings
nmap <leader>d :Dispatch<cr>
nmap <leader>D :Dispatch!<cr>
nmap <leader>st :Start<space>
nmap <leader>St :Start!<space>
nmap <localleader>d :Dispatch<space>
nmap <localleader>D :Dispatch!<space>
