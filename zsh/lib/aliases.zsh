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

# postgresql control
alias pg1='pg_ctl -D /usr/local/var/postgres start -l /usr/local/var/postgres/server.log'
alias pg0='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# vim:set ft=zsh:
