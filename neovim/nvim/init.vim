" NEOVIM config file

" NOTES:
"
" If you want to do custom configuration you can use the file:
"
"     " neovim runtime path
"     $XDG_CONFIG_HOME/nvim/plugin/local.vim
"
" This file is not tracked by this repository and it will be loaded
" by default by neovim.

" Main settings
" =============================================================================

set nocompatible " Don't try to support vi
set encoding=utf-8 " default character encoding

" Set leader keys before anything else
let mapleader      = " "
let maplocalleader = ","

" backups
set nobackup   " No backup
set noswapfile " No swap files

" behaviors
set modeline       " be able to use modelines when a file is loaded
set hidden         " buffers management, don't close the buffers
set autoread       " auto-reload modified files (with no local changes)
set nojoinspaces   " put only one space after joining.
set mouse=a        " enable mouse interactions"

" use the system clipboard as the default register
set clipboard=unnamed,unnamedplus

" indentation
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

" listchars
set listchars=trail:~,tab:▸\ ,eol:¬ " show special characters
set list

" search
set ignorecase  " ignore case in search
set smartcase   " override ignorecase if uppercase is used in search
set hlsearch    " highlight search
set incsearch   " search as characters are entered

" wildmenu
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

" statusline
set notitle            " don't set the terminal title
set laststatus=2       " always show statusline
set number             " you need line numbers
set ruler              " see where you are
set wrap               " wrap long lines without changing it
set visualbell         " use visual bell, not sound
set shortmess=aI       " modify the error and info messages
set scrolloff=3        " screen lines to keep above and below the cursor
set virtualedit+=block " put the cursor anywhere in visual blocks
set cursorline         " show where you are
set lazyredraw

set inccommand=split

" Experimental: save when leaving insert mode
set updatetime=750
au InsertLeave * nested update
au CursorHold * nested update

" Plugins
" =============================================================================
filetype off
call plug#begin()
Plug 'w0rp/ale'
Plug 'kassio/neoterm'

Plug 'janko-m/vim-test'
Plug 'mhinz/vim-grepper'
Plug 'vim-scripts/matchit.zip'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'jgdavey/vim-blockle'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-projectionist'

Plug 'NLKNguyen/papercolor-theme'
Plug 'joshdick/onedark.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'TroyFletcher/vim-colors-synthwave'
Plug 'jacoborus/tender.vim'

Plug 'MarcWeber/vim-addon-local-vimrc'

Plug 'mattn/emmet-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

if executable('scout')
  Plug 'jhbabon/scout.vim'
endif

Plug 'liuchengxu/vim-which-key'
call plug#end()

" Ale
let g:ale_linters = {
      \   'rust': ['rls']
      \ }
let g:ale_fixers = {
      \   'rust': ['rustfmt']
      \ }

" Polyglot
let g:polyglot_disabled = ['graphql']

" Ruby
au BufNewFile,BufRead *.jbuilder set ft=ruby

" Neoterm
let g:neoterm_size = '15%'
let g:neoterm_fixedsize = 1
let g:neoterm_autoscroll = 1

nnoremap <Plug>(console-run-command) :T<space>
nnoremap <Plug>(console-open) :Topen<cr>
nnoremap <Plug>(console-close) :Tclose<cr>

" vim-test
function! NeotermFixStrategy(cmd)
  " call neoterm#do({ 'cmd': a:cmd })
  execute 'rightbelow T ' . a:cmd
endfunction

let g:test#custom_strategies = {'neotermfix': function('NeotermFixStrategy')}
let g:test#strategy = 'neotermfix'

nnoremap <Plug>(test-file) :TestFile<cr>
nnoremap <Plug>(test-nearest) :TestNearest<cr>

" Grepper
let g:grepper = { 'tools': ['rg', 'git', 'ag', 'ack', 'grep'] }

nnoremap <Plug>(search-current-word) :Grepper -noprompt -cword<cr>
nnoremap <Plug>(search-query) :Grepper -query<space>

nnoremap <Plug>(search-rg-current-word) :Grepper -tool rg -noprompt -cword<cr>
nnoremap <Plug>(search-rg-query) :Grepper -tool rg -query<space>

nnoremap <Plug>(search-git-current-word) :Grepper -tool git -noprompt -cword<cr>
nnoremap <Plug>(search-git-query) :Grepper -tool git -query<space>

nnoremap <Plug>(search-ag-current-word) :Grepper -tool ag -noprompt -cword<cr>
nnoremap <Plug>(search-ag-query) :Grepper -tool ag -query<space>

nnoremap <Plug>(search-ack-current-word) :Grepper -tool ack -noprompt -cword<cr>
nnoremap <Plug>(search-ack-query) :Grepper -tool ack -query<space>

nnoremap <Plug>(search-grep-current-word) :Grepper -tool grep -noprompt -cword<cr>
nnoremap <Plug>(search-grep-query) :Grepper -tool grep -query<space>

" Don't load elm.vim mappings
let g:elm_setup_keybindings = 0

" Fugitive
nnoremap <Plug>(git-status) :Gstatus<cr>
nnoremap <Plug>(git-commit) :Gcommit<cr>
nnoremap <Plug>(git-log) :Glog<cr>
nnoremap <Plug>(git-diff) :Gdiff<cr>

" Scout
if executable('scout')
  if executable('rg')
    let g:scout_find_files_command = 'rg --files --hidden --follow --glob "!.git/*" 2>/dev/null'
  endif

  nnoremap <Plug>(files-open-file) :ScoutFiles<cr>
  nnoremap <Plug>(files-open-file-current-dir) :ScoutFiles %:h<cr>
  nnoremap <Plug>(buffers-open-buffer) :ScoutBuffers<cr>
  nnoremap <Plug>(buffers-open-buffer-current-dir) :ScoutBuffers %:h<cr>
endif

nnoremap <Plug>(files-tree-explorer) :Explore<cr>

" Projectionist
if !exists('g:projectionist_transformations')
  let g:projectionist_transformations = {}
endif

" Custom transformations

" rspec
"
" Use it to generate the correct name of the module in the spec
" Is intended to be used after camelcase and colons
"
" @example
"   Given the template
"   describe {camelcase|colons|rspec} do
"
"   Input => describe engines/spec/lib/fancy/awesome do
"   Output => describe Fancy::Awesome do
function! g:projectionist_transformations.rspec(input, o) abort
  return substitute(a:input, '.*Spec::\(\w\+\)::\(.\+\)$', '\2', 'g')
endfunction

let g:projectionist_heuristics = {
      \   "Gemfile|*.gemspec": {
      \     "*_spec.rb": {
      \       "type": "spec",
      \       "template": [
      \         "require 'spec_helper'",
      \         "",
      \         "describe {camelcase|capitalize|colons|rspec} do",
      \         "end"
      \       ]
      \     }
      \   }
      \ }

" Ragtag
let g:ragtag_global_maps = 1

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "snips"]


" Colors

if (has("termguicolors"))
 set termguicolors
endif

syntax enable
set background=dark
colorscheme onedark

" Lightline
let g:lightline = {
      \   'colorscheme': 'one',
      \   'active': {
      \     'left': [
      \       ['mode', 'paste'],
      \       ['gitbranch', 'readonly', 'filename', 'modified']
      \     ],
      \     'right': [
      \       ['linter_checking', 'linter_warnings', 'linter_errors', 'lineinfo'],
      \       ['percent'],
      \       ['fileformat', 'fileencoding', 'filetype']
      \     ]
      \   },
      \   'component_expand': {
      \     'gitbranch': 'fugitive#head',
      \     'linter_checking': 'lightline#ale#checking',
      \     'linter_warnings': 'lightline#ale#warnings',
      \     'linter_errors': 'lightline#ale#errors'
      \   },
      \   'component_type': {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error'
      \   }
      \ }

" Which Key
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:which_key_map =  {}

call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

function! s:my_which_key_format(mapping) abort
  let l:ret = a:mapping
  let l:ret = substitute(l:ret, '\c<cr>$', '', '')
  let l:ret = substitute(l:ret, '^:', '', '')
  let l:ret = substitute(l:ret, '^\c<c-u>', '', '')
  let l:ret = substitute(l:ret, '^<Plug>', '', '')
  return l:ret
endfunction
let g:WhichKeyFormatFunc = function('s:my_which_key_format')

filetype plugin indent on

" Functions
" =============================================================================

" Delete EOL whitespace
" link: http://sartak.org/2011/03/end-of-line-whitespace-in-vim.html
function! StripTrailingWhitespace()
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

" Mappings
" =============================================================================

" Go to Normal mode fast
imap jj <ESC>

" copy file path to clipboard
map <Plug>(files-copy-path) :let @+ = expand("%")<cr>

" add ; or , to the end of the line, when missing
nnoremap <Plug>(misc-semicolon-eol) :s/\([^;]\)$/\1;/<cr>:noh<cr>
nnoremap <Plug>(misc-comma-eol) :s/\([^,]\)$/\1,/<cr>:noh<cr>

" clear highlighted search
nnoremap <Plug>(search-clear-highlighted) :nohl<cr>

" Map trailing whitespace method
nnoremap <Plug>(misc-strip-trailing-whitespace) :call StripTrailingWhitespace()<cr>

" quick list and location list
nnoremap <Plug>(list-quick-open) :copen<cr>
nnoremap <Plug>(list-location-open) :lopen<cr>
nnoremap <Plug>(list-quick-close) :cclose<cr>
nnoremap <Plug>(list-location-close) :lclose<cr>

" Which Key mappings
let g:which_key_map.b = { 'name': '(buffers)' }
nmap <leader>bb <Plug>(buffers-open-buffer)
nmap <leader>bd <Plug>(buffers-open-buffer-current-dir)

let g:which_key_map.c = { 'name': '(console-window)' }
nmap <leader>cr <Plug>(console-run-command)
nmap <leader>co <Plug>(console-open)
nmap <leader>cc <Plug>(console-close)

let g:which_key_map.f = { 'name': '(files)' }
nmap <leader>ff <Plug>(files-open-file)
nmap <leader>fd <Plug>(files-open-file-current-dir)
nmap <leader>ft <Plug>(files-tree-explorer)
nmap <leader>fp <Plug>(files-copy-path)

let g:which_key_map.g = { 'name': '(git)' }
nmap <leader>gs <Plug>(git-status)
nmap <leader>gc <Plug>(git-commit)
nmap <leader>gl <Plug>(git-log)
nmap <leader>gd <Plug>(git-diff)

let g:which_key_map.l = { 'name': '(lists)' }
let g:which_key_map.l.l = { 'name': '(location-list)' }
nmap <leader>llo <Plug>(list-location-open)
nmap <leader>llc <Plug>(list-location-close)
let g:which_key_map.l.q = { 'name': '(quick-list)' }
nmap <leader>lqo <Plug>(list-quick-open)
nmap <leader>lqc <Plug>(list-quick-close)

let g:which_key_map.m = { 'name': '(misc)' }
nmap <silent> <leader>m; <Plug>(misc-semicolon-eol)
nmap <silent> <leader>m, <Plug>(misc-comma-eol)
nmap <silent> <leader>m<space> <Plug>(misc-strip-trailing-whitespace)

let g:which_key_map.p = { 'name': '(programming)' }
let g:which_key_map.p.r = { 'name': '(ruby)' }
" blockle plugin
nmap <leader>prb <Plug>BlockToggle

let g:which_key_map.s = { 'name': '(search)' }
nmap <leader>sw <Plug>(search-current-word)
nmap <leader>sq <Plug>(search-query)
nmap <leader>sc <Plug>(search-clear-highlighted)

let g:which_key_map.s.r = { 'name': '(search-with-rg)' }
nmap <leader>srw <Plug>(search-rg-current-word)
nmap <leader>srq <Plug>(search-rg-query)

let g:which_key_map.s.i = { 'name': '(search-with-git)' }
nmap <leader>siw <Plug>(search-git-current-word)
nmap <leader>siq <Plug>(search-git-query)

let g:which_key_map.s.a = { 'name': '(search-with-ag)' }
nmap <leader>saw <Plug>(search-ag-current-word)
nmap <leader>saq <Plug>(search-ag-query)

let g:which_key_map.s.k = { 'name': '(search-with-ack)' }
nmap <leader>skw <Plug>(search-ack-current-word)
nmap <leader>skq <Plug>(search-ack-query)

let g:which_key_map.s.g = { 'name': '(search-with-grep)' }
nmap <leader>sgw <Plug>(search-grep-current-word)
nmap <leader>sgq <Plug>(search-grep-query)

let g:which_key_map.t = { 'name': '(test)' }
nmap <leader>tf <Plug>(test-file)
nmap <leader>tn <Plug>(test-nearest)
