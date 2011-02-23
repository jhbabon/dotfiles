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

" filetype options
autocmd BufNewFile,BufRead *.php  set filetype=php.html shiftwidth=4 tabstop=4
autocmd BufNewFile,BufRead *.html set shiftwidth=4 tabstop=4
autocmd BufNewFile,BufRead *.js   set shiftwidth=4 tabstop=4
autocmd BufNewFile,BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>

" misc
set number
set ruler
set showcmd
set showmatch
set wildmenu
set nowrap
set hidden
set modeline
set autoread       " auto-reload modified files (with no local changes)
set ignorecase     " ignore case in search
set smartcase      " override ignorecase if uppercase is used in search string
set report=0       " report all changes
set cursorline     " highlight current line
set textwidth=80
set visualbell
set encoding=utf-8
set hidden         " buffers management, don't close the buffers
set title
set shortmess=atI  " modify the error and info messages

" statusline
set statusline=%f\ %{fugitive#statusline()}\ %r%m%h\ %y\ %=%l/%L,%c
set laststatus=2   " always show status-line

" completion
set wildmenu
set wildmode=list:longest,full

" scroll
set scrolloff=3

" commands
set showcmd
set showmatch

" keep swap files in one of these
" set directory=/tmp
" set backupdir=/tmp
" no backup files
set nobackup
set noswapfile " warning: may cause problems if you load huge files or
               " on terminal crash

" better search
set hlsearch
set incsearch

" plugin pathogen
" link: http://www.vim.org/scripts/script.php?script_id=2332

filetype plugin indent on
filetype plugin indent off
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" file-type
filetype on
filetype indent plugin on
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
noremap <buffer> <Leader>; :s/\([^;]\)$/\1;/<CR>:noh<CR>
noremap <buffer> <Leader>, :s/\([^,]\)$/\1,/<CR>:noh<CR>

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
if has("unix") && !has('macunix')
  let g:ackprg = "ack-grep -H --nocolor --nogroup --column"
endif

" gui
if has("gui_running")
  colorscheme bclear
  if has("gui_gnome") || has("gui_gtk2")
    set guifont=Inconsolata\ Medium\ 11
  endif
  if has("gui_mac") || has("gui_macvim")
    set guifont=AnonymousPro:h14
    set guioptions=aAce
  else
  endif
else
  set nocursorline
  set t_Co=16
  colorscheme textmate16
endif
