" vimrc
set nocompatible   " don't try to be compatible with vi

" tabs and spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set backspace=indent,eol,start
set expandtab
set autoindent
set copyindent
set smartindent
set smarttab

" misc
set number
set ruler
set showcmd
set showmatch
set wildmenu
set wrap
set linebreak
set hidden
set modeline
set autoread       " auto-reload modified files (with no local changes)
set ignorecase     " ignore case in search
set smartcase      " override ignorecase if uppercase is used in search string
set report=0       " report all changes
set cursorline     " highlight current line
set textwidth=0
set visualbell
set encoding=utf-8
set hidden         " buffers management, don't close the buffers
set title
set shortmess=atI  " modify the error and info messages
set synmaxcol=120  " maximum column in which to search for syntax items

" statusline
set statusline=%f\ %{fugitive#statusline()}\ %r%m%h\ %y\ %=%l/%L,%c
set laststatus=2   " always show status-line

" completion
set wildmenu
set wildmode=list:longest,full

" scroll
set scrolloff=3

" keep swap files in one of these
set directory=/tmp
set backupdir=/tmp
" no backup files
" set nobackup
" set noswapfile " warning: may cause problems if you load huge files or
               " on terminal crash

" better search
set hlsearch
set incsearch

" plugin vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" All Bundles here:
" github
Bundle 'edsono/vim-matchit'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'msanders/snipmate.vim'
Bundle 'mileszs/ack.vim'
Bundle 'godlygeek/tabular'
Bundle 'altercation/vim-colors-solarized'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'vim-scripts/taglist.vim'
Bundle 'vim-scripts/AutoComplPop'
Bundle 'vim-scripts/L9'
Bundle 'vim-scripts/FuzzyFinder'
Bundle 'othree/html5.vim'
Bundle 'sjl/gundo.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'juvenn/mustache.vim'
Bundle 'vim-scripts/nginx.vim'
Bundle 'kana/vim-fakeclip'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'itspriddle/vim-jquery'

" file-type
filetype on
filetype plugin indent on
autocmd FileType make	set noexpandtab

" show trailing white-space
let ruby_space_errors = 1
let c_space_errors = 1
let javascript_space_errors = 1
let php_space_errors = 1

" fix backspace key in xterm
inoremap  <BS>

" syntax coloring
syntax enable

" minimum window height = 0
set wmh=0

" mapleader
let mapleader = ","

" special characters
nmap <leader>l :set list!<CR>
set listchars=trail:~,tab:▸\ ,eol:¬
set list

" spell check
nmap <leader>sp :set spell!<CR>
nmap <leader>ses :set spelllang=es<CR>
nmap <leader>sen :set spelllang=en<CR>

" save with Ctrl-s"
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a

" no highlighted search"
nmap <leader>nh :nohl<CR>

" folding
" link: http://github.com/dcrec1/vimfiles/blob/master/vimrc
nnoremap <space> za
set foldmethod=indent   " fold based on indent
set foldnestmax=3       " deepest fold is 3 levels
set nofoldenable        " dont fold by default

" moving
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" brackets
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
inoremap < <><Left>
inoremap " ""<Left>
inoremap ' ''<Left>

" empty lines
" link: http://vim.wikia.com/wiki/Quickly_adding_and_deleting_empty_lines
" delete the empty line below and above
nnoremap <Leader>dl m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <Leader>dL m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
" add an empty line below and above
nnoremap <Leader>al :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <Leader>aL :set paste<CR>m`O<Esc>``:set nopaste<CR>

" add ; or , to the end of the line, when missing
nnoremap <Leader>; :s/\([^;]\)$/\1;/<CR>:noh<CR>
nnoremap <Leader>, :s/\([^,]\)$/\1,/<CR>:noh<CR>

" delete EOL whitespace
" link: http://sartak.org/2011/03/end-of-line-whitespace-in-vim.html
function! <SID>StripTrailingWhitespace()
  " preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nmap <silent> <Leader><space> :call <SID>StripTrailingWhitespace()<CR>

" change background
nnoremap <Leader>bl :set background=light<CR>
nnoremap <Leader>bd :set background=dark<CR>

" plugins
" ragtag
let g:ragtag_global_maps = 1

" nerdcommenter
let NERDSpaceDelims=1
let NERDShutUp=1

" nerdtree
nmap <F5> :NERDTree<CR>
nnoremap <Leader>nt :NERDTreeToggle<CR>

" fuzzyfinder
nnoremap <Leader>fb :FufBuffer<CR>
nnoremap <Leader>ff :FufFile<CR>
nnoremap <Leader>fv :FufCoverageFile<CR>
nnoremap <Leader>fj :FufJumpList<CR>
nnoremap <Leader>fc :FufChangeList<CR>
nnoremap <Leader>fl :FufLine<CR>
nnoremap <Leader>fr :FufRenewCache<CR>

" snipmate
let g:snips_author = "Juan Hernández Babón"

" sparkup
let g:sparkupNextMapping = '<c-x>'

" fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gd :Gdiff<CR>

" ack
let g:ackprg = "ack -H --nocolor --nogroup --column"
" fast search for TODO, FIXME and NOTE labels
command! -nargs=0 Todos exec "Ack TODO"
command! -nargs=0 Fixmes exec "Ack FIXME"
command! -nargs=0 Notes exec "Ack NOTE"

" tabularize
nmap <Leader>t> :Tabularize /=><CR>
vmap <Leader>t> :Tabularize /=><CR>
nmap <Leader>t= :Tabularize /=<CR>
vmap <Leader>t= :Tabularize /=<CR>
nmap <Leader>t: :Tabularize /:\zs<CR>
vmap <Leader>t: :Tabularize /:\zs<CR>

" autocomplpop
" let g:acp_enableAtStartup = 0
nnoremap <Leader>pe :AcpEnable<CR>
nnoremap <Leader>pd :AcpDisable<CR>
nnoremap <Leader>pl :AcpLock<CR>
nnoremap <Leader>pu :AcpUnlock<CR>

" gundo
nnoremap <Leader>ut :GundoToggle<CR>

" matchit
runtime macros/matchit.vim

" jquery
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
nnoremap <Leader>jq :set syntax=jquery<CR>

" markdown
" FUNCTION: ConvertMarkdown()
" description: Convert markdown file to a html file and open it
" dependencies: markdown cli
function! <SID>ConvertMarkdown()
  let l:mkd_file = expand("%:p")
  let l:html_file = expand("%:p:r") . ".html"
  exe "!markdown --html4tags " . l:mkd_file . " > " . l:html_file
  exe "drop " . l:html_file
endfunction
nmap <silent> <Leader>mk :call <SID>ConvertMarkdown()<CR>

" gui
set t_Co=256
set background=dark
colorscheme solarized
if has("gui_running")
  " windows size
  " link: http://effectif.com/vim/changing-window-size
  nmap <leader>1 :set lines=40 columns=85<CR><C-w>o
  nmap <leader>2 :set lines=50 columns=171<CR><C-w>v

  if has("gui_gnome") || has("gui_gtk2")
    set guifont=Inconsolata\ Medium\ 11
  endif
  if has("gui_mac") || has("gui_macvim")
    set guifont=AnonymousPro:h14
    set guioptions=aAce
  endif
endif

" highlight long lines
match CursorLine /\%81v.*/

" autosave
" link: http://stackoverflow.com/questions/6991638/how-to-auto-save-a-file-every-1-second-in-vim
" FIXME: doesn't work well with unsaved files and files outside the focus
au BufRead,BufNewFile * let b:save_time = localtime()
au CursorHold * call UpdateFile()
let g:autosave_time = 1

function! UpdateFile()
  if((localtime() - b:save_time) >= g:autosave_time)
    update
    let b:save_time = localtime()
  endif
endfunction
au BufWritePre * let b:save_time = localtime()

" Privatize and Protectize ruby methods
" link: http://robots.thoughtbot.com/post/1986730994/keep-your-privates-close
function! Privatize(...)
  let priorMethod = PriorMethodDefinition()
  let scope = a:0 == 1 ? a:1 : "private"
  exec "normal o". scope . " :" . priorMethod  . "\<Esc>=="
endfunction

function! PriorMethodDefinition()
  let lineNumber = search('def', 'bn')
  let line       = getline(lineNumber)
  if line == 0
    echo "No prior method definition found"
  endif
  return matchlist(line, 'def \(\w\+\).*')[1]
endfunction

map <Leader>rp :call Privatize()<CR>
map <Leader>ro :call Privatize("protected")<CR>
