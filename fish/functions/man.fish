function man --description "wrap the 'man' manual page opener to use color in formatting"
  # based on this group of settings and explanation for them:
  # http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
  # converted to fish shell syntax thanks to this page:
  # http://askubuntu.com/questions/522599/how-to-get-color-man-pages-under-fish-shell/650192

  # start of bold:
  set -x LESS_TERMCAP_md (printf "\e[1;31m")
  # end of all formatting:
  set -x LESS_TERMCAP_me (printf "\e[0m")

  # start of standout (inverted):
  set -x LESS_TERMCAP_so (printf "\e[1;40;92m")
  # end of standout (inverted):
  set -x LESS_TERMCAP_se (printf "\e[0m")
  # (no change – I like the default)

  # start of underline:
  set -x LESS_TERMCAP_us (printf "\e[1;32m")
  # end of underline:
  set -x LESS_TERMCAP_ue (printf "\e[0m")
  # (no change – I like the default)

  env man $argv
end
