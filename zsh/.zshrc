# main zshrc file

# Global options
# -----------------------------------------------
setopt correct_all
setopt autonamedirs
setopt autocd
setopt autopushd
setopt pushdignoredups
setopt cdablevarS

setopt globdots      # match dot files
setopt sh_word_split # passes "foo bar" as "foo" "bar" to commands,
                     # backward compatibility with sh/ksh

autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# Aliases
# -----------------------------------------------
alias _='sudo'
alias cl='clear'
alias vi='vim'
alias mdp="mkdir -p"
alias ping='ping -c 4 '
alias pingg='ping www.google.com'
alias rake="noglob rake" # makes rake work nicely with zsh
alias ..='cd ..'
alias ...='cd ../..'

alias man='nocorrect man'
alias mv='nocorrect mv -i'
alias mkdir='nocorrect mkdir'
alias cp='nocorrect cp'
alias cap='nocorrect cap'
alias rm='nocorrect rm -i'
alias rspec='nocorrect rspec'

alias bi='bundle install'
alias bu='bundle update'
alias be='bundle exec'

alias g="git"
alias v="vim"

# History
# show full history
alias hs='fc -l 1'
# search command in history
# @link: http://viget.com/extend/level-up-your-shell-game#history-expansions
alias "h?"="history | grep"

# find the option for using colors in ls, depending on the version: Linux or BSD
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
alias ll="ls -lh"
alias la="ll -a"

# ack
which ack-grep &>/dev/null 2>&1 && alias ack='ack-grep'
# reload shell environment
alias rld="echo '---> shell: reload'; exec $SHELL -l"
# full reload with rbenv rehash
alias fld="echo '---> rbenv: rehash'; rbenv rehash; rld"

# higher-order function: map
# link: https://coderwall.com/p/4tkkpq
alias map="xargs -n1"

# Bindkeys
# -----------------------------------------------
bindkey -v # vi mode
bindkey "^R" history-incremental-search-backward

# edit command line with $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Completion
# -----------------------------------------------
autoload -U compinit
compinit

unsetopt menucomplete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt automenu         # show completion menu on succesive tab press
setopt extendedglob     # new features for pattern matching
setopt completeinword   # not just at the end
setopt alwaystoend      # when complete from middle, move cursor

zmodload -i zsh/complist

# completion styles
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # case insensitive
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
zstyle ':completion:*:descriptions' format "%B---- %d%b"
zstyle ':completion:*:messages' format '%B%U---- %d%u%b'
zstyle ':completion:*:warnings' format '%B%U---- no match for: %d%u%b'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion::complete:*' use-cache 1
[[ -d ~/.zsh-cache ]] || mkdir -p ~/.zsh-cache
zstyle ':completion::complete:*' cache-path ~/.zsh-cache/

# History
# -----------------------------------------------

# ignore duplicate history entries
setopt histignoredups
# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history

# keep more history
export HISTFILE=$HOME/.zshistory
export HISTSIZE=10000
export SAVEHIST=10000
export DIRSTACKSIZE=50

# Helpers
# -----------------------------------------------

# get:
#   * description: creates a dir and gets to it.
function get() {
  mkdir -p "$1" && cd "$1";
}

# any:
#   * description: a very handy function from the Grml distro’s
#                  excellent zsh config that lets you search
#                  for running processes.
#   * link: http://onethingwell.org/post/14669173541/any
function any() {
  emulate -L zsh
  unsetopt KSH_ARRAYS
  if [[ -z "$1" ]] ; then
    echo "any - grep for process(es) by keyword" >&2
    echo "Usage: any " >&2 ; return 1
  else
    ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
  fi
}

# randompass:
#   * description: small random password generator.
#   * params: a integer with the length of the password (default: 8).
#   * link: http://blog.leenix.co.uk/2010/04/bashsh-random-stringpassword-generator.html
function randompass() {
  local _length
  if [ $1 ]; then
    _length=$1
  else
    _length=8
  fi

  pass=</dev/urandom tr -dc A-Za-z0-9 | head -c $_length
  echo $pass
}

# prj:
#   * description: go to the source dir of a project
#                  the project should be in:
#
#                  $HOME/src/[project-name]{/src}
#
#   * params: a string with the name of the project.
function prj() {
  if [ $# -eq 1 ]; then
    cd "$HOME/src/$1/src" 2>/dev/null ||
      cd "$HOME/src/$1"  2>/dev/null ||
      echo "---> no such file or directory: $HOME/src/$1{/src}"
  else
    echo "Nav to project's source code."
    echo "Each project should be under: $HOME/src"
    echo "Usage: $0 project_dir_name"
  fi
}

# sf:
#   * description: create a .safe dir in $PWD to indicate
#                  that the bin dir in $PWD is secure to use.
function sf() {
  [[ -d $PWD/.safe ]] || (mkdir -p $PWD/.safe && echo '---> safe: done')
}

# explain:
#   * description: use the remote service explain.com from the terminal.
#   * link: https://github.com/schneems/explain_shell#without-rubygems
function explain() {
  # base url with first command already injected
  # $ explain tar
  #   => http://explainshel.com/explain/tar?args=
  url="http://explainshell.com/explain/$1?args="

  # removes $1 (tar) from arguments ($@)
  shift;

  # iterates over remaining args and adds builds the rest of the url
  for i in "$@"; do
    url=$url"$i""+"
  done

  # opens url in browser
  open $url
}

# zmv: zsh renaming tool
# @link: http://www.mfasold.net/blog/2008/11/moving-or-renaming-multiple-files/
#
# Example:
#   % mmv '(*).json' '$1.rb'
autoload -U zmv
alias mmv='noglob zmv -W'

# zsh syntax highlighting
if [[ -d "/usr/local/share/zsh-syntax-highlighting" ]] ; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi


# Theme
# -----------------------------------------------
autoload -U colors
colors
setopt prompt_subst

PROMPT="%{$fg[white]%}%2~ %# %{$reset_color%}"

RPROMPT='$(~/.bin/git-cwd-info 2>/dev/null)'

# vim:set ft=zsh:
