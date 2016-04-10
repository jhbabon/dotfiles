" Author: Juan Hernández Babón <juan.hernandez.babon@gmail.com>
" Source: https://github.com/jhbabon/dotfiles

" Vim settings {{{
set nocompatible   " be iMproved!
set encoding=utf-8 " default character encoding
set modeline       " be able to use modelines when a file is loaded
set notitle        " don't set the terminal title
set hidden         " buffers management, don't close the buffers
set autoread       " auto-reload modified files (with no local changes)
set report=0       " report all changes

" wait X seconds on key codes
set timeout
set ttimeout
set ttimeoutlen=5

set laststatus=2       " always show statusline
set number             " you need line numbers
set ruler              " see where you are
set wrap               " wrap long lines without changing it
set visualbell         " use visual bell, not sound
set shortmess=aI       " modify the error and info messages
set scrolloff=3        " screen lines to keep above and below the cursor
set virtualedit+=block " put the cursor anywhere in visual blocks
set nojoinspaces       " put only one space after joining.

set listchars=trail:~,tab:▸\ ,eol:¬ " show special characters
set list

set cursorline     " show where you are

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

" use the system clipboard as the default register
set clipboard=unnamed,unnamedplus

set ignorecase  " ignore case in search
set smartcase   " override ignorecase if uppercase is used in search
set hlsearch    " highlight search
set incsearch   " search as characters are entered

set nobackup    " No backup
set noswapfile  " No swap files

set lazyredraw
" }}}

" Plugins {{{
filetype off
call plug#begin()
Plug 'edsono/vim-matchit'
Plug 'scrooloose/syntastic'
Plug 'drmingdrmer/xptemplate'
Plug 'sheerun/vim-polyglot'
Plug 'kana/vim-smartinput'
Plug 'jgdavey/vim-blockle'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'wellle/targets.vim'

Plug 'tpope/vim-projectionist'

Plug 'joshdick/onedark.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'NLKNguyen/papercolor-theme'

Plug 'racer-rust/vim-racer'

if has('nvim')
  Plug 'radenling/vim-dispatch-neovim'
endif

if executable('fzf')
  Plug 'junegunn/fzf.vim'
  set rtp+=/usr/local/opt/fzf
endif
call plug#end()

" Matchit {{{2
runtime macros/matchit.vim
" }}}2

" Ragtag {{{2
let g:ragtag_global_maps = 1
" }}}2

" Lightline {{{2
let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ }
" }}}2

" Syntastic {{{2
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1
" }}}2

" xptemplate {{{2
let g:xptemplate_key = '<Tab>'
" }}}

" Dispatch {{{2
autocmd FileType ruby let b:dispatch = '/usr/bin/env ruby %'
autocmd FileType rust let b:dispatch = 'cargo build'
" }}}2

" Fugitive {{{2
" link: http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
autocmd BufReadPost fugitive://* set bufhidden=delete
" }}}2

" Projectionist{{{2
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
      \       "dispatch": "bundle exec rspec {file}",
      \       "type": "spec",
      \       "template": [
      \         "require 'spec_helper'",
      \         "",
      \         "describe {camelcase|colons|rspec} do",
      \         "end"
      \       ]
      \     }
      \   }
      \ }
" }}}2

" Nvim Python {{{2
if has('nvim')
  let g:python_host_prog = '/usr/local/Cellar/python/2.7.11/bin/python'
endif
" }}}2
" }}}

" Filetypes {{{1
filetype plugin indent on

" ruby {{{2
augroup rubyfiles
  autocmd!
  autocmd BufRead,BufNewFile {Vagrantfile,Strikefile,Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*,*.god} set ft=ruby
augroup END
" }}}2

" markdown {{{2
augroup markdownfiles
  autocmd!
  autocmd BufRead,BufNewFile *.md set ft=markdown
augroup END
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'ruby']
" }}}2
" }}}1

" Colors {{{
syntax enable
set background=light
colorscheme PaperColor
" }}}

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
" }}}2
" }}}1

" Mappings {{{
let mapleader      = " "
let maplocalleader = ","

" Go to Normal mode fast
imap jj <ESC>

" copy file path to clipboard
map <leader>% :let @* = expand("%")<cr>

" add ; or , to the end of the line, when missing
nnoremap <leader>; :s/\([^;]\)$/\1;/<CR>:noh<CR>
nnoremap <leader>, :s/\([^,]\)$/\1,/<CR>:noh<CR>

" manage empty lines
" link: http://vim.wikia.com/wiki/Quickly_adding_and_deleting_empty_lines
" add an empty line below and above
nnoremap <leader>plu :set paste<CR>m`O<Esc>``:set nopaste<CR>
nnoremap <leader>pld :set paste<CR>m`o<Esc>``:set nopaste<CR>

" clear highlighted search
map <leader>nh :nohl<CR>

" Map trailing whitespace method
nmap <silent> <leader><space> :call <SID>StripTrailingWhitespace()<CR>

" Files {{{2
if executable('fzf')
  let g:fzf_command_prefix = 'FZF'
  nnoremap <leader>ff :FZFFiles<cr>
  nnoremap <leader>fb :FZFBuffers<cr>
  nnoremap <leader>ft :FZFTags<cr>
  nnoremap <leader>fh :FZFHistory<cr>
  nnoremap \ :FZFAg<space>
  " bind K to grep word under cursor
  nnoremap K :FZFAg <C-R><C-W><cr>:cw<cr>

  nnoremap <leader>fe :Explore<cr>
endif
" }}}2

" Dispatch {{{2
nmap <leader>d :Dispatch<cr>
nmap <leader>D :Dispatch!<cr>
nmap <leader>st :Start<space>
nmap <leader>St :Start!<space>
nmap <localleader>d :Dispatch<space>
nmap <localleader>D :Dispatch!<space>
" }}}2

" Fugitive {{{2
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gd :Gdiff<CR>
" }}}2

" ruby {{{2
" Convert ruby 1.8 hash syntax to 1.9 TODO: review
nmap <silent> <leader>rh :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>

nmap <leader>rs :Dispatch bundle exec rspec %<cr>

function! <SID>RSpecLine()
  execute 'Dispatch bundle exec rspec %:' . line(".")
endfunction
nmap <leader>rsl :call <SID>RSpecLine()<cr>

let g:blockle_mapping = '<leader>rb'
" }}}2

" Ag {{{2
" @link: http://robots.thoughtbot.com/faster-grepping-in-vim
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
endif
" }}}2

" }}}

" vim:foldmethod=marker:foldlevel=0
