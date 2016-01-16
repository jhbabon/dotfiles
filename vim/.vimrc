" Author: Juan Hernández Babón <juan.hernandez.babon@gmail.com>
" Source: https://github.com/jhbabon/dotfiles

" Constants {{{1
let $MYVIMRUNTIMEPATH=split(&runtimepath, ',')[0]
" }}}1

" Basic options {{{1
set nocompatible " be iMproved!

set encoding=utf-8 " default character encoding
set modeline       " be able to use modelines when a file is loaded
set notitle        " don't set the terminal title
set ttyfast        " fast terminal connection
set hidden         " buffers management, don't close the buffers
set autoread       " auto-reload modified files (with no local changes)
set report=0       " report all changes

" wait 4 seconds on key codes
set notimeout
set ttimeout
set ttimeoutlen=4
" }}}1

" Leader & shortcuts {{{1
let mapleader      = ","
let maplocalleader = "-"

inoremap jj <ESC>
" }}}1

" UI & layout {{{1
set laststatus=2   " always show statusline
set number         " you need line numbers
set relativenumber " it helps you count lines
set ruler          " see where you are
set wrap           " wrap long lines without changing it
set linebreak      " wrap the lines by words
set textwidth=0    " don't break long lines
set visualbell     " use visual bell, not sound
set shortmess=atI  " modify the error and info messages
set scrolloff=3    " number of screen lines to keep above and below the cursor

set virtualedit+=block " the cursor can be positioned where there is
                       " no actual character

set nojoinspaces " insert only one space when joining lines that
                 " contain sentence-terminating punctuation like `.`.

set lazyredraw " redraw only when we need to.

set listchars=trail:~,tab:▸\ ,eol:¬ " show special characters
set list
" show or not the list
nmap <leader>l :set list!<CR>

" only show cursorline in the current window and in normal mode.
augroup cursorline
  autocmd!
  autocmd WinLeave * set nocursorline
  autocmd WinEnter * set cursorline
  autocmd InsertEnter * set nocursorline
  autocmd InsertLeave * set cursorline
augroup END

" make sure vim returns to the same line when you reopen a file.
augroup line_return
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" highlight long lines
match CursorLine /\%81v.*/

" highlight last inserted text
nnoremap gV `[v`]

" Folding {{{1
set foldenable        " fold by default
set foldlevelstart=10 " open most folds by default
set foldnestmax=10    " 10 nested fold max
set foldmethod=indent " fold based on indent level
" }}}1

" Tabs & spaces {{{1
set tabstop=2      " number of visual spaces per TAB.
set shiftwidth=2   " number of spaces to use for each step of (auto)indent.
set softtabstop=2  " number of spaces in tab when editing.
set shiftround     " round indent to multiple of 'shiftwidth'
set expandtab      " tabs are spaces
set backspace=indent,eol,start
set smarttab
set autoindent
set copyindent
set smartindent
" }}}1

" Menu completions {{{1
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
" }}}1

" Clipboard {{{1
" use the system clipboard as the default register
set clipboard=unnamed,unnamedplus
" copy file path to clipboard
map <leader>% :let @* = expand("%")<cr>
" }}}1

" Search {{{1
set ignorecase  " ignore case in search
set smartcase   " override ignorecase if uppercase is used in search
set hlsearch    " highlight search
set incsearch   " search as characters are entered

" clear highlighted search
nmap <leader>nh :nohl<CR>

" keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv
" }}}1

" Backups {{{1
set backup                                    " enable backups
set undodir=$MYVIMRUNTIMEPATH/tmp/undo,/var/tmp,/tmp     " undo files
set backupdir=$MYVIMRUNTIMEPATH/tmp/backup,/var/tmp,/tmp " backups
set directory=$MYVIMRUNTIMEPATH/tmp/swap,/var/tmp,/tmp   " swap files
set writebackup
" }}}1

" Misc {{{1
" quickly edit/reload the vimrc file
nmap <silent> <leader>ve :e $MYVIMRC<CR>
nmap <silent> <leader>vs :so $MYVIMRC<CR>

" add ; or , to the end of the line, when missing
nnoremap <leader>; :s/\([^;]\)$/\1;/<CR>:noh<CR>
nnoremap <leader>, :s/\([^,]\)$/\1,/<CR>:noh<CR>

" manage empty lines
" link: http://vim.wikia.com/wiki/Quickly_adding_and_deleting_empty_lines
" add an empty line below and above
nnoremap <leader>al :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <leader>aL :set paste<CR>m`O<Esc>``:set nopaste<CR>
" }}}1

" Plugins {{{1
" Vundle {{{2
filetype off

set rtp+=$MYVIMRUNTIMEPATH/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'edsono/vim-matchit'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'drmingdrmer/xptemplate'
Plugin 'godlygeek/tabular'
Plugin 'altercation/vim-colors-solarized'
Plugin 'othree/html5.vim'
Plugin 'kchmck/vim-coffee-script'
" Plugin 'mustache/vim-mustache-handlebars'
" Plugin 'vim-scripts/nginx.vim'
Plugin 'kana/vim-fakeclip'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'rstacruz/sparkup', { 'rtp': 'vim' }
" Plugin 'groenewege/vim-less'
Plugin 'kana/vim-smartinput'
Plugin 'jgdavey/vim-blockle'
Plugin 'vim-ruby/vim-ruby'
Plugin 'pangloss/vim-javascript'
" Plugin 'guns/vim-clojure-static'
" Plugin 'tpope/vim-classpath'
" Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
" Plugin 'Blackrush/vim-gocode'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-dispatch'
if has('nvim')
  Plugin 'radenling/vim-dispatch-neovim'
endif
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-eunuch'
Plugin 'rust-lang/rust.vim'

call vundle#end()
" }}}2

" Ragtag {{{2
let g:ragtag_global_maps = 1
" }}}2

" Nerdcommenter {{{2
let NERDSpaceDelims=1
let NERDShutUp=1
" }}}2

" Nerdtree {{{2
nmap <F5> :NERDTree<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
" }}}2

" Ag {{{2
" @link: http://robots.thoughtbot.com/faster-grepping-in-vim
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

nnoremap K :grep! "\b<C-R><C-W>\b"<cr>:cw<cr> " bind K to grep word under cursor
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<space>
" }}}2

" CtrlP {{{2
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

nnoremap <localleader>p :CtrlP<cr>
nnoremap <localleader>b :CtrlPBuffer<cr>
nnoremap <localleader>m :CtrlPMRUFiles<cr>
nnoremap <localleader>t :CtrlPTag<cr>
" }}}2

" Sparkup {{{2
let g:sparkupNextMapping = '<c-x>'
" }}}2

" Fugitive {{{2
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gd :Gdiff<CR>
" link: http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
autocmd BufReadPost fugitive://* set bufhidden=delete
" }}}2

" Tabularize {{{2
nmap <leader>t> :Tabularize /=><CR>
vmap <leader>t> :Tabularize /=><CR>
nmap <leader>t= :Tabularize /=<CR>
vmap <leader>t= :Tabularize /=<CR>
nmap <leader>t: :Tabularize /:\zs<CR>
vmap <leader>t: :Tabularize /:\zs<CR>
" }}}2

" Matchit {{{2
runtime macros/matchit.vim
" }}}2

" jQuery {{{2
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
nnoremap <leader>jq :set syntax=jquery<CR>
" }}}2

" Nginx {{{2
nnoremap <leader>nx :set ft=nginx<CR>
" }}}2

" vim-classpath {{{2
" save the classpath cache in .viminfo
set viminfo+=!
" }}}2

" vim-airline {{{2
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='solarized'
" }}}2

" Syntastic {{{2
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1
" }}}2

" xtemplate {{{2
let g:xptemplate_key = '<Tab>'
" }}}

" Dispatch {{{2
autocmd FileType ruby let b:dispatch = '/usr/bin/env ruby %'
nmap <leader>d :Dispatch<cr>
nmap <leader>D :Dispatch!<cr>
nmap <leader>st :Start<space>
nmap <leader>St :Start!<space>
nmap <localleader>d :Dispatch<space>
nmap <localleader>D :Dispatch!<space>
nmap <leader>sp :Dispatch bundle exec rspec %<cr>
" }}}2
" }}}1

" Filetypes {{{1
filetype on
filetype plugin indent on

" objective-c file type {{{2
augroup objcfiles
  autocmd!
  autocmd BufRead,BufNewFile *.m set ft=objc
augroup END
" }}}2

" ruby {{{2
augroup rubyfiles
  autocmd!
  autocmd BufRead,BufNewFile {Vagrantfile,Strikefile,Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*,*.god} set ft=ruby
augroup END
" }}}2

" go {{{2
augroup gofiles
  autocmd!
  autocmd FileType go autocmd BufWritePre <buffer> Fmt
augroup END
" }}}2
" }}}1

" Colors {{{1
set t_Co=256
set background=dark
colorscheme solarized
syntax enable
" }}}1

" Functions {{{1
" Delete EOL whitespace {{{2
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
" }}}2

" Markdown {{{2
" description:  convert markdown file to a html file and open it
" dependencies: markdown cli
" -----------------------------------------------------------------------------
function! <SID>ConvertMarkdown()
  let l:mkd_file = expand("%:p")
  let l:html_file = expand("%:p:r") . ".html"
  exe "!markdown --html4tags " . l:mkd_file . " > " . l:html_file
  exe "drop " . l:html_file
endfunction
nmap <silent> <leader>cmk :call <SID>ConvertMarkdown()<CR>
" }}}2

" Autosave {{{2
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
" }}}2

" Privatize and protectize ruby methods {{{2
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
" }}}2

" Converting variables to or from CamelCase {{{2
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
" }}}2

" Convert ruby 1.8 hash syntax to 1.9 {{{2
nmap <silent> <leader>rh :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>
" }}}2

" }}}1

" vim:foldmethod=marker:foldlevel=0
