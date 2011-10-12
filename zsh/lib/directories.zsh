#! /bin/zsh
# directories manipulation
setopt autonamedirs
setopt autocd
setopt autopushd
setopt pushdignoredups
setopt cdablevarS

# basic directory operations
alias ...='cd ../..'
alias -- -='cd -'
alias ..='cd ..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd/='cd /'
alias mdp="mkdir -p"

# frequent directories
cdpath=($HOME/Code $HOME/Projects)

# mkdir & cd to it
function go() {
  mkdir -p "$1" && cd "$1";
}

# vim:set ft=zsh:
