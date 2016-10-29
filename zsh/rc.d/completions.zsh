# Completions
# -----------------------------------------------
autoload -U compinit
compinit

zmodload -i zsh/complist

# completion styles
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # case insensitive
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
zstyle ':completion:*:warnings' format '%B%U---- no match for: %d%u%b'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
