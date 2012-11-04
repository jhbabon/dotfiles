# zmv: zsh renaming tool
# @link: http://www.mfasold.net/blog/2008/11/moving-or-renaming-multiple-files/
#
# Example:
#   % mmv '(*).json' '$1.rb'

autoload -U zmv
alias mmv='noglob zmv -W'

# vim:set ft=zsh:
