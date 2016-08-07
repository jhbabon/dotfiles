" Go to Normal mode fast
imap jj <ESC>

" copy file path to clipboard
map <leader>% :let @* = expand("%")<cr>

" add ; or , to the end of the line, when missing
nnoremap <leader>; :s/\([^;]\)$/\1;/<CR>:noh<CR>
nnoremap <leader>, :s/\([^,]\)$/\1,/<CR>:noh<CR>

" clear highlighted search
map <leader>nh :nohl<CR>

" Map trailing whitespace method
nmap <silent> <leader><space> :call StripTrailingWhitespace()<CR>

" Ag
" @link: http://robots.thoughtbot.com/faster-grepping-in-vim
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
endif
