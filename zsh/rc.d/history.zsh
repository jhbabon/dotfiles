# History
# -----------------------------------------------

# ignore duplicate history entries
setopt histignoredups
# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history

# keep more history
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export DIRSTACKSIZE=50
