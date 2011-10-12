#! /bin/zsh
# key bindings

# vi mode
bindkey -v

# use incremental search
bindkey "^R" history-incremental-search-backward
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# vim:set ft=zsh:
