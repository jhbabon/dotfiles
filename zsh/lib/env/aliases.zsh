# aliases

# Super user
alias _='sudo'

# show history
alias history='fc -l 1'

# list direcory contents
# find the option for using colors in ls, depending on the version: Linux or BSD
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
alias ll="ls -l"
alias la="ls -la"
alias lsa='ls -lah'
alias sl=ls # often screw this up

# ack
which ack-grep &>/dev/null 2>&1 && alias ack='ack-grep'
alias afind='ack-grep -il'

# various
alias cl='clear'
alias vi='vim'
alias mdp="mkdir -p"
alias ping='ping -c 4 '
alias pingg='ping www.google.com'
alias rld="echo 'reload!'; exec $SHELL" # reload shell environment

# postgresql controls Linux Dev
alias pgstart="/usr/local/bin/pg_ctl -D $HOME/Projects/db/pgsql/data -l $HOME/Projects/db/pgsql/data/psql.log start"
alias pgstop="/usr/local/bin/pg_ctl -D $HOME/Projects/db/pgsql/data stop"
alias psql='psql -h localhost'

# vim:set ft=zsh:
