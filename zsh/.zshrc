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
alias hs='fc -l 1' # show history
alias cl='clear'
alias vi='vim'
alias mdp="mkdir -p"
alias ping='ping -c 4 '
alias pingg='ping www.google.com'
alias rake="noglob rake" # makes rake work nicely with zsh
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'

alias man='nocorrect man'
alias mv='nocorrect mv -i'
alias mkdir='nocorrect mkdir'
alias cp='nocorrect cp'
alias cap='nocorrect cap'
alias rm='nocorrect rm -i'

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

# go:
#   * description: creates a dir and goes to it.
function go() {
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
#                  $HOME/Code/projects/[project-name]{/src}
#
#   * params: a string with the name of the project.
function prj() {
  if [ $# -eq 1 ]; then
    cd "$HOME/Code/projects/$1/src" 2>/dev/null ||
      cd "$HOME/Code/projects/$1"  2>/dev/null ||
      echo "---> no such file or directory: $HOME/Code/projects/$1{/src}"
  else
    echo "Nav to project's source code."
    echo "Each project should be under: $HOME/Code/projects"
    echo "Usage: src project_dir_name"
  fi
}

# sf:
#   * description: create a .safe dir in $PWD to indicate
#                  that the bin dir in $PWD is secure to use.
function sf() {
  [[ -s $PWD/.safe ]] && (mkdir -p $PWD/.safe && echo '---> safe: done')
}

# zmv: zsh renaming tool
# @link: http://www.mfasold.net/blog/2008/11/moving-or-renaming-multiple-files/
#
# Example:
#   % mmv '(*).json' '$1.rb'
autoload -U zmv
alias mmv='noglob zmv -W'


# TODO: Theme
# -----------------------------------------------
autoload -U colors
colors
setopt prompt_subst

PROMPT='
%30>...>%2~%<< %# %{$reset_color%}'

# TODO: use local vars
# TODO: clean up a bit
GIT_REPO_PATH=`git rev-parse --git-dir 2>/dev/null`
if [[ $GIT_REPO_PATH != '' ]]; then

  GIT_BRANCH=`git symbolic-ref -q HEAD | sed 's/refs\/heads\///'`
  GIT_COMMIT_ID=`git rev-parse --short HEAD 2>/dev/null`

  GIT_MODE=""
  if [[ -e "$GIT_REPO_PATH/BISECT_LOG" ]]; then
    GIT_MODE=" +bisect"
  elif [[ -e "$GIT_REPO_PATH/MERGE_HEAD" ]]; then
    GIT_MODE=" +merge"
  elif [[ -e "$GIT_REPO_PATH/rebase" || -e "$GIT_REPO_PATH/rebase-apply" || -e "$GIT_REPO_PATH/rebase-merge" || -e "$GIT_REPO_PATH/../.dotest" ]]; then
    GIT_MODE=" +rebase"
  fi

  GIT_STATUS=""
  if ! git diff --quiet --cached 2>/dev/null; then
    GIT_STATUS="$GIT_STATUS+"
  fi

  if [[ `git ls-files -u` != "" ]]; then
    GIT_STATUS="$GIT_STATUS*"
  fi

  if [[ `git ls-files -m` != "" ]]; then
    GIT_STATUS="$GIT_STATUS!"
  fi

  if [[ `git ls-files --others --exclude-standard` != "" ]]; then
    GIT_STATUS="$GIT_STATUS?"
  fi

  RPROMPT=" %{[37m%}$GIT_BRANCH %{[37m%}$GIT_COMMIT_ID%{[37m%}$GIT_MODE $GIT_STATUS%{$reset_color%}"
fi

# vim:set ft=zsh:
