# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="serenity"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git bundler brew rvm osx rails)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# custom aliases
alias cl='clear'
alias vi='vim'
alias mdp="mkdir -p"
alias ping='ping -c 4 '
alias pingg='ping www.google.com'

# postgresql controls Mac OS X
alias pg1='pg_ctl -D /usr/local/var/postgres start -l /usr/local/var/postgres/server.log'
alias pg0='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# postgresql controls Linux Dev
alias pgstart="/usr/local/bin/pg_ctl -D $HOME/Projects/db/pgsql/data -l $HOME/Projects/db/pgsql/data/psql.log start"
alias pgstop="/usr/local/bin/pg_ctl -D $HOME/Projects/db/pgsql/data stop"
alias psql='psql -h localhost'

# vim:set ft=zsh:
