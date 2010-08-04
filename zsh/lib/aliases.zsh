# aliases

alias cl='clear'
alias vi='vim'
# Find the option for using colors in ls, depending on the version: Linux or BSD
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
alias ll="ls -l"
alias la="ll -a"
alias ping='ping -c 4 '
alias pingg='ping www.google.com'

# vim:set ft=zsh: