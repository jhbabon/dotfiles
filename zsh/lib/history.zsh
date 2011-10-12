#! /bin/zsh
# history

# ignore duplicate history entries
setopt histignoredups

# keep more history
export HISTFILE=$HOME/.zshistory
export HISTSIZE=200
export SAVEHIST=200
export DIRSTACKSIZE=30

# vim:set ft=zsh:
