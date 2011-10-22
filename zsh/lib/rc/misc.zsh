# misc options

## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

## file rename magick
bindkey "^[m" copy-prev-shell-word

setopt globdots      # match dot files
setopt sh_word_split # passes "foo bar" as "foo" "bar" to commands,
                     # backward compatibility with sh/ksh

# vim:set ft=zsh:
