# completion
autoload -U compinit
compinit

setopt automenu                   # automatically use menu completion after the
                                  # second consecutive request for completion,
                                  # for example by pressing the TAB key repeatedly
setopt listpacked                 # compact completion lists
setopt nolisttypes                # show types in completion
setopt extendedglob               # new features for pattern matching
setopt completeinword             # not just at the end
setopt alwaystoend                # when complete from middle, move cursor
setopt printexitvalue             # alert me if something's failed

# completion styles
zstyle ':completion:*:descriptions' format "%B---- %d%b"
zstyle ':completion:*:messages' format '%B%U---- %d%u%b'
zstyle ':completion:*:warnings' format '%B%U---- no match for: %d%u%b'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

# vim:set ft=zsh: