alias _='sudo'
alias cl='clear'
alias pingg='ping -c 4 www.duckduckgo.com'
alias rake='noglob rake' # makes rake work nicely with zsh
alias ..='cd ..'
alias ...='cd ../..'
alias rm='rm -i'

alias bi='bundle install'
alias bu='bundle update'
alias be='bundle exec'

# History
# show full history
alias hs='fc -l 1'
# search command in history
# @link: http://viget.com/extend/level-up-your-shell-game#history-expansions
alias 'h?'='history | grep'
# don't save current history in the global history file.
# history will be lost once the session is closed.
alias hide='fc -pa' 

# find the option for using colors in ls, depending on the version: Linux or BSD
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
alias ll='ls -lh'
alias la='ll -a'

# higher-order function: map
# link: https://coderwall.com/p/4tkkpq
alias map='xargs -n1'

# disk space
alias dus='du -Psckx * | sort -nr'

# Format JSON text with python
alias pyson='python -m json.tool'

# most used tools
alias g='git'
alias nv='nvim'

# mimic macOS pbcopy and pbpaste
cmd_exists 'pbcopy' || alias pbcopy='xclip -i -selection clipboard'
cmd_exists 'pbpaste' || alias pbpaste='xclip -o -selection clipboard'

# ssh with a valid TERM
alias tssh='TERM=xterm-256color ssh'
