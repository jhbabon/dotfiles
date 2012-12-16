# Trust the bin dir in safe git repositories
export PATH=".git/safe/../../bin:$PATH"

_safe() {
  [ -s $PWD/.git ] && (mkdir -p $PWD/.git/safe && echo '---> safe: done')
}

# vim:set ft=zsh:
