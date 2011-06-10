# aliases

alias cl='clear'
alias vi='vim'
# find the option for using colors in ls, depending on the version: Linux or BSD
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
alias ll="ls -l"
alias la="ll -a"
alias mdp="mkdir -p"
alias ping='ping -c 4 '
alias pingg='ping www.google.com'

# bundle alias
alias bli='bundle install'
alias blu='bundle update'
alias blx='bundle exec'

# postgresql controls Mac OS X
alias pg1='pg_ctl -D /usr/local/var/postgres start -l /usr/local/var/postgres/server.log'
alias pg0='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# postgresql controls Linux Dev
alias pgstart="/usr/local/bin/pg_ctl -D $HOME/Projects/db/pgsql/data -l $HOME/Projects/db/pgsql/data/psql.log start"
alias pgstop="/usr/local/bin/pg_ctl -D $HOME/Projects/db/pgsql/data stop"
alias psql='psql -h localhost'

# vim:set ft=zsh:
