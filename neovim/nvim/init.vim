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

set belloff+=ctrlg

" Prevent text jumping with linters/lsp integrations
set signcolumn=yes

" Experimental: save when leaving insert mode
set updatetime=750
au InsertLeave * nested update
au CursorHold * nested update

" Plugins
"
" All plugins are loaded using the default (neo)vim's package manager
" see :h packages
"
" Plugins are installed using minpac: https://github.com/k-takata/minpac
" =============================================================================
filetype off

" Load minpac in order to install/update/clean plugins
" Minpac doesn't need to be loaded all the time
function! PackInit() abort
  " NOTE: To remove a plugin `PackClean` has to be called after removing
  "   the `minpac#add()` line
  packadd minpac

  call minpac#init()
  " Minpac can update itself by adding it here
  call minpac#add('k-takata/minpac', { 'type': 'opt' })

  " Start plugins
  "
  " Can be loaded right away
  " ---------------------------------------------------------------------------

  " Match pairs like (), if else, etc
  call minpac#add('vim-scripts/matchit.zip')

  " Git integration
  call minpac#add('tpope/vim-fugitive')

  " This plugin is all about 'surroundings': parentheses, brackets, quotes,
  " XML tags, and more. Provides mappings to easily delete, change and
  " add such surroundings in pairs
  call minpac#add('tpope/vim-surround')

  " Plugin that helps to end certain structures automatically
  " (i.e: adds `end` after `if`)
  call minpac#add('tpope/vim-endwise')

  " Add/remove comments
  call minpac#add('tpope/vim-commentary')

  " Helpers for UNIX shell commands (i.e: Delete files, etc)
  call minpac#add('tpope/vim-eunuch')

  " The interactive scratchpad
  call minpac#add('metakirby5/codi.vim')

  " Optional (opt) plugins
  "
  " Loaded on demand or after their configurations are set
  "
  " If a plugin needs custom configurations it's better to load it with
  " `packadd!` after the configurations are set
  "
  " Example:
  "
  "   let g:myplugin_config = 1
  "   packadd! myplugin
  " ---------------------------------------------------------------------------

  " Colorschemes
  call minpac#add('NLKNguyen/papercolor-theme', { 'type': 'opt' })
  call minpac#add('joshdick/onedark.vim', { 'type': 'opt' })
  call minpac#add('rakr/vim-one', { 'type': 'opt' })
  call minpac#add('ayu-theme/ayu-vim', { 'type': 'opt' })
  call minpac#add('haishanh/night-owl.vim', { 'type': 'opt' })
  call minpac#add('challenger-deep-theme/vim', { 'type': 'opt', 'name': 'challenger-deep' })
  call minpac#add('dracula/vim', { 'type': 'opt', 'name': 'dracula' })

  " MUcomplete is a minimalist autocompletion plugin for Vim.
  call minpac#add('lifepillar/vim-mucomplete', { 'type': 'opt' })

  " Plugin to insert or delete brackets, parens, quotes in pair
  call minpac#add('jiangmiao/auto-pairs', { 'type': 'opt' })

  " Use snippets in vim
  call minpac#add('SirVer/ultisnips', { 'type': 'opt' })
  " Pack of snippets for different languages
  call minpac#add('honza/vim-snippets', { 'type': 'opt' })

  " Asynchronous Lint Engine
  call minpac#add('dense-analysis/ale', { 'type': 'opt' })

  " Wrappers around :terminal functions
  call minpac#add('kassio/neoterm', { 'type': 'opt' })

  " Run tests for many different languages/frameworks. It can use neoterm
  call minpac#add('janko-m/vim-test', { 'type': 'opt' })

  " Async search with a grep tool (i.e: ripgrep)
  call minpac#add('mhinz/vim-grepper', { 'type': 'opt' })

  " A collection of language packs
  call minpac#add('sheerun/vim-polyglot', { 'type': 'opt' })

  " Fancier status line
  call minpac#add('itchyny/lightline.vim', { 'type': 'opt' })
  call minpac#add('maximbaz/lightline-ale', { 'type': 'opt' })

  " Jump to any definition and references
  call minpac#add('pechorin/any-jump.vim', { 'type': 'opt' })

  " Load local .vimrc directories
  call minpac#add('embear/vim-localvimrc', { 'type': 'opt' })

  " https://emmet.io/
  call minpac#add('mattn/emmet-vim', { 'type': 'opt' })

  " Fuzzy finder for files and buffers
  call minpac#add('jhbabon/scout.vim', { 'type': 'opt' })

  " Granular project configuration using 'projections'
  call minpac#add('tpope/vim-projectionist', { 'type': 'opt' })

  " Show keybindings and mappings in a popup
  call minpac#add('liuchengxu/vim-which-key', { 'type': 'opt' })
endfunction

" PackBootstrap is used the first time, to install and then exit nvim
command! PackBootstrap call PackInit() | call minpac#update('', { 'do': 'quit' })
command! PackReset     call PackInit() | call minpac#update('', { 'do': 'call minpac#clean()' })
command! PackUpdate    call PackInit() | call minpac#update('', { 'do': 'call minpac#status()' })
command! PackClean     call PackInit() | call minpac#clean()
command! PackStatus    call PackInit() | call minpac#status()

" vim-fugitive
" -----------------------------------------------------------------------------
nnoremap <Plug>(git-status) :Gstatus<cr>
nnoremap <Plug>(git-commit) :Gcommit<cr>
nnoremap <Plug>(git-log) :Glog<cr>
nnoremap <Plug>(git-diff) :Gdiff<cr>

" vim-mucomplete
" -----------------------------------------------------------------------------
set completeopt-=preview
set completeopt+=menuone,noselect
let g:mucomplete#completion_delay = 50
let g:mucomplete#reopen_immediately = 0
let g:mucomplete#chains = {
    \ 'default' : ['ulti', 'omni', 'keyn'],
    \ }
let g:mucomplete#enable_auto_at_startup = 1

packadd! vim-mucomplete

" auto-pairs
" -----------------------------------------------------------------------------
let g:AutoPairsMapSpace = 0
let g:AutoPairsMapCR = 0
let g:AutoPairsMapCh = 0
imap <silent> <expr> <space> pumvisible()
    \ ? "<space>"
    \ : "<c-r>=AutoPairsSpace()<cr>"

packadd! auto-pairs

" ultisnips
" -----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["snips"]

packadd! ultisnips
packadd! vim-snippets

" ale
" -----------------------------------------------------------------------------
let g:airline#extensions#ale#enabled = 0
set omnifunc=ale#completion#OmniFunc " to show completions with vim-mucomplete

nnoremap <Plug>(lsp-goto-definition)  :ALEGoToDefinition<CR>
nnoremap <Plug>(lsp-type-definition)  :ALEGoToTypeDefinition<CR>
nnoremap <Plug>(lsp-hover)            :ALEHover<CR>
nnoremap <Plug>(lsp-references)       :ALEFindReferences<CR>
nnoremap <Plug>(lsp-formatting)       :ALEFix<CR>
nnoremap <Plug>(lsp-workspace-symbol) :ALESymbolSearch<CR>
nnoremap <Plug>(lsp-rename)           :ALERename<CR>

packadd! ale

" neoterm
" -----------------------------------------------------------------------------
let g:neoterm_size = '15%'
let g:neoterm_fixedsize = 1
let g:neoterm_autoscroll = 1

nnoremap <Plug>(console-run-command) :T<space>
nnoremap <Plug>(console-open) :Topen<cr>
nnoremap <Plug>(console-close) :Tclose<cr>

packadd! neoterm

" vim-test
" -----------------------------------------------------------------------------
function! NeotermFixStrategy(cmd)
  " call neoterm#do({ 'cmd': a:cmd })
  execute 'rightbelow T ' . a:cmd
endfunction

let g:test#custom_strategies = {'neotermfix': function('NeotermFixStrategy')}
let g:test#strategy = 'neotermfix'

nnoremap <Plug>(test-file) :TestFile<cr>
nnoremap <Plug>(test-nearest) :TestNearest<cr>

packadd! vim-test

" vim-grepper
" -----------------------------------------------------------------------------
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

packadd! vim-grepper

" vim-polyglot
" -----------------------------------------------------------------------------
let g:polyglot_disabled = ['graphql']
" Don't load elm.vim mappings
let g:elm_setup_keybindings = 0

packadd! vim-polyglot

" lightline.vim
" -----------------------------------------------------------------------------
let g:lightline = {
      \   'colorscheme': 'dracula',
      \   'active': {
      \     'left': [
      \       ['mode', 'paste'],
      \       ['gitbranch', 'readonly', 'filename', 'modified']
      \     ],
      \     'right': [
      \       ['linter_infos', 'linter_warnings', 'linter_errors', 'lineinfo'],
      \       ['percent'],
      \       ['fileformat', 'fileencoding', 'filetype']
      \     ]
      \   },
      \   'component_expand': {
      \     'gitbranch': 'fugitive#head',
      \     'linter_infos': 'lightline#ale#infos',
      \     'linter_warnings': 'lightline#ale#warnings',
      \     'linter_errors': 'lightline#ale#errors'
      \   },
      \   'component_type': {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error'
      \   }
      \ }

packadd! lightline.vim
packadd! lightline-ale

" any-jump.vim
" -----------------------------------------------------------------------------
let g:any_jump_disable_default_keybindings = 1
nnoremap <Plug>(jump-current-word) :AnyJump<CR>
xnoremap <Plug>(jump-visual-word) :AnyJumpVisual<CR>
nnoremap <Plug>(jump-previous-file) :AnyJumpBack<CR>
nnoremap <Plug>(jump-last-results) :AnyJumpLastResults<CR>

packadd! any-jump.vim

" vim-localvimrc
" -----------------------------------------------------------------------------
let g:localvimrc_persistent = 1
let g:localvimrc_name = ['.vimrc']

packadd! vim-localvimrc

" emmet-vim
" -----------------------------------------------------------------------------
" With <space> emmet mappings will be displayed in which_key prompt
let g:user_emmet_leader_key = '<space>e'
let g:user_emmet_mode = 'nv' " load only in normal and visual mode
packadd! emmet-vim

" scout.vim
" -----------------------------------------------------------------------------
if executable('scout')
  let g:scout_window_type = 'floating'

  if executable('rg')
    let g:scout_find_files_command = 'rg --files --hidden --follow --glob "!.git/*" 2>/dev/null'
  endif

  nnoremap <Plug>(files-open-file) :ScoutFiles<cr>
  nnoremap <Plug>(files-open-file-current-dir) :ScoutFiles %:h<cr>
  nnoremap <Plug>(buffers-open-buffer) :ScoutBuffers<cr>
  nnoremap <Plug>(buffers-open-buffer-current-dir) :ScoutBuffers %:h<cr>

  packadd! scout.vim
endif

nnoremap <Plug>(files-tree-explorer) :Explore<cr>

" vim-projectionist
" -----------------------------------------------------------------------------
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

packadd! vim-projectionist

" vim-which-key
" -----------------------------------------------------------------------------
augroup MyWhichKey
  autocmd! FileType which_key
  autocmd  FileType which_key set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

let g:which_key_map =  {}

function! s:my_which_key_format(mapping) abort
  let l:ret = a:mapping
  let l:ret = substitute(l:ret, '\c<cr>$', '', '')
  let l:ret = substitute(l:ret, '^:', '', '')
  let l:ret = substitute(l:ret, '^\c<c-u>', '', '')
  let l:ret = substitute(l:ret, '^<Plug>', '', '')
  return l:ret
endfunction
let g:WhichKeyFormatFunc = function('s:my_which_key_format')

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

packadd! vim-which-key
call which_key#register('<Space>', "g:which_key_map")

" Languages' settings
" =============================================================================
augroup LanguageSettings
  au!
  " Ruby
  au BufNewFile,BufRead *.jbuilder set ft=ruby

  " JSX files
  " This is done to make UltiSnips JavaScript to work with .jsx files
  au BufRead,BufNewFile *.jsx setlocal filetype=javascriptreact.javascript
augroup END

" Colors
" =============================================================================
if (has("termguicolors"))
 set termguicolors
endif

packadd! dracula
syntax enable
set background=dark
colorscheme dracula

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

" go fast to Normal mode
imap jj <ESC>

" copy file path to clipboard
map <Plug>(files-copy-path) :let @+ = expand("%")<cr>

" add ; or , to the end of the line, when missing
nnoremap <Plug>(misc-semicolon-eol) :s/\([^;]\)$/\1;/<cr>:noh<cr>
nnoremap <Plug>(misc-comma-eol) :s/\([^,]\)$/\1,/<cr>:noh<cr>

" clear highlighted search
nnoremap <Plug>(search-clear-highlighted) :nohl<cr>

" map trailing whitespace method
nnoremap <Plug>(misc-strip-trailing-whitespace) :call StripTrailingWhitespace()<cr>

" vim-which-key mappings
let g:which_key_map.b = { 'name': '(buffers)' }
nmap <leader>bb <Plug>(buffers-open-buffer)
nmap <leader>bd <Plug>(buffers-open-buffer-current-dir)

let g:which_key_map.c = { 'name': '(console-window)' }
nmap <leader>cr <Plug>(console-run-command)
nmap <leader>co <Plug>(console-open)
nmap <leader>cc <Plug>(console-close)

let g:which_key_map.e = { 'name': '(emmet)' }

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

let g:which_key_map.j = { 'name': '(jump)' }
nmap <leader>jw <Plug>(jump-current-word)
xmap <leader>jw <Plug>(jump-visual-word)
nmap <leader>jb <Plug>(jump-previous-file)
nmap <leader>jl <Plug>(jump-last-results)

let g:which_key_map.l = { 'name': '(lsp)' }
nmap <leader>ld <Plug>(lsp-goto-definition)
nmap <leader>lt <Plug>(lsp-type-definition)
nmap <leader>lh <Plug>(lsp-hover)
nmap <leader>lr <Plug>(lsp-references)
nmap <leader>lf <Plug>(lsp-formatting)
nmap <leader>ln <Plug>(lsp-rename)
let g:which_key_map.l.s = { 'name': '(symbol)' }
nmap <leader>lsw <Plug>(lsp-workspace-symbol)

let g:which_key_map.m = { 'name': '(misc)' }
nmap <silent> <leader>m; <Plug>(misc-semicolon-eol)
nmap <silent> <leader>m, <Plug>(misc-comma-eol)
nmap <silent> <leader>m<space> <Plug>(misc-strip-trailing-whitespace)

let g:which_key_map.p = { 'name': '(programming)' }
nmap <leader>pf <Plug>(ale_fix)

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
