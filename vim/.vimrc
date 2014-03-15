" .vimrc
" Author: Juan Hernández Babón <juan.hernandez.babon@gmail.com>
" Source: https://github.com/jhbabon/dotfiles
"
" some code is borrowed from: http://github.com/sjl/dotfiles.git


" * ======================================================================== *
" * basic options                                                            *
" * ======================================================================== *
set nocompatible " be iMproved!

let mapleader      = ","
let maplocalleader = "-"

set encoding=utf-8 " default character encoding
set modeline       " be able to use modelines when a file is loaded
set number         " you need line numbers
set ruler          " see where you are
set showcmd        " see what are you doing
set showmatch      " see mathing brackets
set wrap           " wrap long lines without changing it
set linebreak      " wrap the lines by words
set hidden         " buffers management, don't close the buffers
                   " TODO: consider to use autowriteall instead
set autoread       " auto-reload modified files (with no local changes)
set report=0       " report all changes
set textwidth=0    " don't break long lines
set visualbell     " use visual bell, not sound
set notitle        " don't set the terminal title
set shortmess=atI  " modify the error and info messages
set ttyfast        " fast terminal connection

set scrolloff=3    " number of screen lines to keep above and below the cursor

set virtualedit+=block " the cursor can be positioned where there is
                       " no actual character

set foldmethod=manual " don't fold anyway
set nofoldenable      " don't fold by default

set nojoinspaces " insert only one space when joining lines that
                 " contain sentence-terminating punctuation like `.`.

" get out fast from insert mode
inoremap jj <ESC>

" tabs and spaces
" -----------------------------------------------------------------------------
set tabstop=2
set shiftwidth=2
set softtabstop=2
set backspace=indent,eol,start
set shiftround " round indent to multiple of 'shiftwidth'
set expandtab
set smarttab
set autoindent
set copyindent
set smartindent

" menu completions
" -----------------------------------------------------------------------------
set wildmenu
set wildmode=list:longest,full

set wildignore+=.hg,.git,.svn                    " version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " vim swap files
set wildignore+=*.DS_Store                       " osx bullshit
set wildignore+=*.pyc                            " python byte code
set wildignore+=*.orig                           " merge resolution files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip         " tmp files

" special characters
" -----------------------------------------------------------------------------
set listchars=trail:~,tab:▸\ ,eol:¬
set list
" show or not the list
nmap <leader>l :set list!<CR>

" timeout on key codes but not mappings
" -----------------------------------------------------------------------------
set notimeout
set ttimeout
set ttimeoutlen=10


" clipboard
" -----------------------------------------------------------------------------
" use the system clipboard as the default register
set clipboard=unnamed,unnamedplus
" copy file path to clipboard
map <leader>% :let @* = expand("%")<cr>


" * ======================================================================== *
" * search options                                                           *
" * ======================================================================== *
set ignorecase  " ignore case in search
set smartcase   " override ignorecase if uppercase is used in search
set hlsearch    " highlight search
set incsearch   " While typing a search command, show where the pattern,
                " as it was typed so far, matches.
" clear highlighted search
nmap <leader>nh :nohl<CR>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv


" * ======================================================================== *
" * cursorline                                                               *
" * ======================================================================== *
" only show cursorline in the current window and in normal mode.
augroup cline
  au!
  au WinLeave * set nocursorline
  au WinEnter * set cursorline
  au InsertEnter * set nocursorline
  au InsertLeave * set cursorline
augroup END


" * ======================================================================== *
" * line return                                                              *
" * ======================================================================== *
" make sure vim returns to the same line when you reopen a file.
augroup line_return
  au!
  au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END


" * ======================================================================== *
" * backups                                                                  *
" * ======================================================================== *
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                  " enable backups
set noswapfile


" * ======================================================================== *
" * spell check                                                              *
" * ======================================================================== *
nmap <leader>sp :set spell!<CR>
nmap <leader>ses :set spelllang=es<CR>
nmap <leader>sen :set spelllang=en<CR>


" * ======================================================================== *
" * motions                                                                  *
" * ======================================================================== *
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
noremap <leader>v <C-w>v


" * ======================================================================== *
" * quickly edit/reload the vimrc file                                       *
" * ======================================================================== *
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>


" * ======================================================================== *
" * add ; or , to the end of the line, when missing                          *
" * ======================================================================== *
nnoremap <leader>; :s/\([^;]\)$/\1;/<CR>:noh<CR>
nnoremap <leader>, :s/\([^,]\)$/\1,/<CR>:noh<CR>


" * ======================================================================== *
" * manage empty lines                                                       *
" * link: http://vim.wikia.com/wiki/Quickly_adding_and_deleting_empty_lines  *
" * ======================================================================== *

" delete the empty line below and above
nnoremap <leader>dl m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <leader>dL m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
" add an empty line below and above
nnoremap <leader>al :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <leader>aL :set paste<CR>m`O<Esc>``:set nopaste<CR>


" * ======================================================================== *
" * sudo to write                                                            *
" * ======================================================================== *
cnoremap w!! w !sudo tee % >/dev/null


" * ======================================================================== *
" * typos                                                                    *
" * ======================================================================== *
command! -bang E e<bang>
command! -bang Q q<bang>
" command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>


" * ======================================================================== *
" * plugins                                                                  *
" * ======================================================================== *

" neobundle
" -----------------------------------------------------------------------------
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'edsono/vim-matchit'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-ragtag'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'godlygeek/tabular'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-scripts/taglist.vim'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'kana/vim-fakeclip'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'nelstrom/vim-textobj-rubyblock'
NeoBundle 'rstacruz/sparkup', { 'rtp': 'vim/' }
NeoBundle 'kana/vim-smartinput'
NeoBundle 'jgdavey/vim-blockle'
" NeoBundle 'guns/vim-clojure-static'
NeoBundle 'tpope/vim-classpath'
NeoBundle 'tpope/vim-fireplace'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'bling/vim-airline'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'sheerun/vim-polyglot'

" ragtag
" -----------------------------------------------------------------------------
let g:ragtag_global_maps = 1

" nerdcommenter
" -----------------------------------------------------------------------------
let NERDSpaceDelims=1
let NERDShutUp=1

" nerdtree
" -----------------------------------------------------------------------------
nmap <F5> :NERDTree<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>

" ag
" @link: http://robots.thoughtbot.com/faster-grepping-in-vim
" -----------------------------------------------------------------------------
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

nnoremap K :grep! "\b<C-R><C-W>\b"<cr>:cw<cr> " bind K to grep word under cursor
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<space>

" ctrlp
" -----------------------------------------------------------------------------
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

nnoremap <localleader>p :CtrlP<cr>
nnoremap <localleader>b :CtrlPBuffer<cr>
nnoremap <localleader>m :CtrlPMRUFiles<cr>

" sparkup
" -----------------------------------------------------------------------------
let g:sparkupNextMapping = '<c-x>'

" fugitive
" -----------------------------------------------------------------------------
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gd :Gdiff<CR>
" link: http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
autocmd BufReadPost fugitive://* set bufhidden=delete

" tabularize
" -----------------------------------------------------------------------------
nmap <leader>t> :Tabularize /=><CR>
vmap <leader>t> :Tabularize /=><CR>
nmap <leader>t= :Tabularize /=<CR>
vmap <leader>t= :Tabularize /=<CR>
nmap <leader>t: :Tabularize /:\zs<CR>
vmap <leader>t: :Tabularize /:\zs<CR>

" gundo
" -----------------------------------------------------------------------------
nnoremap <leader>ut :GundoToggle<CR>

" matchit
" -----------------------------------------------------------------------------
runtime macros/matchit.vim

" vim-classpath
" -----------------------------------------------------------------------------
" save the classpath cache in .viminfo
set viminfo+=!

" vim-airline
" -----------------------------------------------------------------------------
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='solarized'

" go
" -----------------------------------------------------------------------------
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" syntastic
" -----------------------------------------------------------------------------
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1

" * ======================================================================== *
" * file-types                                                               *
" * ======================================================================== *
filetype on
filetype plugin indent on

" objective-c file type
au BufRead,BufNewFile *.m set ft=objc

" ruby files
au BufRead,BufNewFile {Vagrantfile,Strikefile,Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*,*.god} set ft=ruby

" mustache files
au BufRead,BufNewFile {*.html.mustache} set ft=html.mustache
au BufRead,BufNewFile {*.json.mustache} set ft=json.mustache
au BufRead,BufNewFile {*.js.mustache} set ft=js.mustache

" css, less and scss
" Use <leader>S to sort properties.  Turns this:
"
"     p {
"         width: 200px;
"         height: 100px;
"         background: red;
"
"         ...
"     }
"
" into this:

"     p {
"         background: red;
"         height: 100px;
"         width: 200px;
"
"         ...
"     }
au BufNewFile,BufRead *.less,*.css,*.scss nnoremap <buffer> <localleader>al ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>


" * ======================================================================== *
" * statusline, colors and gui                                               *
" * ======================================================================== *

set laststatus=2  " always show statusline

set t_Co=256
set background=dark
colorscheme solarized
syntax on

" highlight long lines
match CursorLine /\%81v.*/

if has("gui_running")
  if has("gui_gnome") || has("gui_gtk2")
    set guifont=Inconsolata\ Medium\ 11
  endif

  if has("gui_mac") || has("gui_macvim")
    set guifont=Inconsolata:h14
    set guioptions=aAce
  endif
endif


" * ======================================================================== *
" * functions                                                                *
" * ======================================================================== *

" delete EOL whitespace
" link: http://sartak.org/2011/03/end-of-line-whitespace-in-vim.html
" -----------------------------------------------------------------------------
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
nmap <silent> <leader><space> :call <SID>StripTrailingWhitespace()<CR>

" markdown:     convert markdown file to a html file and open it
" dependencies: markdown cli
" -----------------------------------------------------------------------------
function! <SID>ConvertMarkdown()
  let l:mkd_file = expand("%:p")
  let l:html_file = expand("%:p:r") . ".html"
  exe "!markdown --html4tags " . l:mkd_file . " > " . l:html_file
  exe "drop " . l:html_file
endfunction
nmap <silent> <leader>cmk :call <SID>ConvertMarkdown()<CR>

" autosave
" link: http://stackoverflow.com/questions/6991638/how-to-auto-save-a-file-every-1-second-in-vim
" -----------------------------------------------------------------------------
function! UpdateFile()
  if((localtime() - b:save_time) >= g:autosave_time)
    update
    let b:save_time = localtime()
  endif
endfunction

au BufRead,BufNewFile * silent! let b:save_time = localtime()
au CursorHold * silent! call UpdateFile()
silent! let g:autosave_time = 1
au BufWritePre * silent! let b:save_time = localtime()

" privatize and protectize ruby methods
" link: http://robots.thoughtbot.com/post/1986730994/keep-your-privates-close
" -----------------------------------------------------------------------------
function! PriorRubyMethodDefinition()
  let lineNumber = search('def', 'bn')
  let line       = getline(lineNumber)
  if line == 0
    echo "No prior method definition found"
  endif
  return matchlist(line, 'def \(\w\+\).*')[1]
endfunction

" param: the string with the kind of scope to apply to the method
"        (default: "privatize")
function! PrivatizeRubyMethod(...)
  let priorMethod = PriorRubyMethodDefinition()
  let scope = a:0 == 1 ? a:1 : "private"
  exec "normal o". scope . " :" . priorMethod  . "\<Esc>=="
endfunction

map <leader>rp :call PrivatizeRubyMethod()<CR>
map <leader>ro :call PrivatizeRubyMethod("protected")<CR>


" converting variables to or from CamelCase
" link: http://vim.wikia.com/wiki/Converting_variables_to_or_from_camel_case
" -----------------------------------------------------------------------------

" convert under_score to CamelCase in current line
" param: the string that indicates if the first letter should be uppercase or
"        lowercase (default: "lower").
function! <SID>FromUnderScoreToCamel(...)
  let firstLetter = a:0 == 1 ? a:1 : "lower"
  if firstLetter == 'upper'
    silent! s#\(\%(\<\l\+\)\%(_\)\@=\)\|_\(\l\)#\u\1\2#g
  else
    silent! s#_\(\l\)#\u\1#g
  endif
endfunction
nmap <silent> <leader>uc :call <SID>FromUnderScoreToCamel()<CR>
nmap <silent> <leader>uC :call <SID>FromUnderScoreToCamel("upper")<CR>

" convert CamelCase to under_score in current line
function! <SID>FromCamelToUnderScore()
  silent! s#\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2#g
endfunction
nmap <silent> <leader>Cu :call <SID>FromCamelToUnderScore()<CR>

" promote variable to rspec let
" link: http://coderwall.com/p/th43aw?i=16&p=1&q=&t=code-vim-ruby-rspec-minitest
" -----------------------------------------------------------------------------
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
command! PromoteToLet :call PromoteToLet()
nmap <silent> <leader>pl :call PromoteToLet()<CR>

" convert ruby 1.8 hash syntax to 1.9
" -----------------------------------------------------------------------------
nmap <silent> <leader>rh :%s/:\(\w\+\)\(\s\?\)=> /\1:\2/g<CR>

" ctags for ruby: get tags for a ruby project
" dependencies: bundler gem, ctags
" link: http://coderwall.com/p/4pvjla
" -----------------------------------------------------------------------------
function! <SID>RubyCtags()
  exe "!bundle list --paths=true | xargs ctags --extra=+f --exclude=.git --exclude=log --exclude=tmp -R *"
endfunction
nmap <silent> <leader>rt :call <SID>RubyCtags()<CR>

" remove current file from the system and also remove its buffer.
" -----------------------------------------------------------------------------
function! Rm()
  call delete(expand("%")) | bdelete!
endfunction
nnoremap <leader>rm :call Rm()<cr>

