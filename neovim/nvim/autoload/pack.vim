" ======================================================================
" pack.vim is a wrapper around minpac
"
" It does two things:
"
"   * Register plugins in minpac to install/update/remove them
"   * Loads optional (opt) packages with packadd after registering
"     them with minpac
"
" This way we define plugins only once
"
" NOTE: To remove a plugin you'll need to call PackClean after removing
"   any `pack#start` or `pack#add` call.
" ======================================================================

let s:plugins = {}

" Initialize minpac with all the registered plugins
function! s:init_minpac() abort
  packadd minpac

  call minpac#init()

  " Minpac can update itself by adding it here
  call minpac#add('k-takata/minpac', { 'type': 'opt' })

  for [repo, opts] in items(s:plugins)
    call minpac#add(repo, opts)
  endfor
endfunction

" Register all Pack* commands to install, update and remove plugins
function! pack#setup() abort
  command! PackBootstrap call s:init_minpac() | call minpac#update('', { 'do': 'quit' })
  command! PackReset     call s:init_minpac() | call minpac#update('', { 'do': 'call minpac#clean()' })
  command! PackUpdate    call s:init_minpac() | call minpac#update('', { 'do': 'call minpac#status()' })
  command! PackClean     call s:init_minpac() | call minpac#clean()
  command! PackStatus    call s:init_minpac() | call minpac#status()
endfunction

" Add a plugin of the type 'start'
"
" see `minpac#add` for the list of arguments
"
" These are loaded when calling packloadall or after loading the init.vim file
function! pack#start(repo, ...) abort
  let l:opts = get(a:000, 0, {})
  " Force the type to be 'start'
  let l:opts['type'] = 'start'
  " We don't really do anything except adding the plugin to the global list
  " As long as the dir exists in the packpath it will be loaded by (neo)vim
  let s:plugins[a:repo] = l:opts
endfunction

" Add a plugin of the type 'opt' and load it with `packadd!`
"
" see `minpac#add` for the list of arguments
"
" This function replaces the two step process of calling `minpac#add`
" and then `packadd!`
"
" Example:
"   " Before
"   call minpac#add('tpope/vim-fugitive', { 'type': 'opt', 'name': 'fugitive' })
"   packadd! fugitive
"
"   " After (you don't need the 'type' option)
"   call pack#add('tpope/vim-fugitive', { 'name': 'fugitive' })
"
" If you want to load all the files in the plugin right away with `packadd`
" pass the option `{ 'lazy': 0 }`:
"
" Example: eager load
"   call pack#add('tpope/vim-fugitive', { 'lazy': 0 })
function! pack#add(repo, ...) abort
  let l:opts = get(a:000, 0, { 'lazy': v:true })
  let l:opts['type'] = 'opt'

  let s:plugins[a:repo] = l:opts

  let l:name = ''
  if has_key(l:opts, 'name')
    let l:name = l:opts['name']
  else
    let l:name = substitute(a:repo, '^.*/', '', '')
  endif

  let l:cmd = 'packadd!'

  if has_key(l:opts, 'lazy') && !l:opts['lazy']
    let l:cmd = 'packadd'
    unlet l:opts.lazy
  endif

  " optional (opt) packages have to be loaded using packadd(!)
  execute printf('%s %s', l:cmd, l:name)
endfunction
