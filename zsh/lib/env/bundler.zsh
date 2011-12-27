# original bundler plugin from oh-my-zsh

alias be="bundle exec"
alias bi="bundle install"
alias bl="bundle list"
alias bu="bundle update"
alias bp="bundle package"

# The following is based on https://github.com/gma/bundler-exec

bundled_commands=(cap capify cucumber guard heroku rackup rake rspec ruby shotgun spec spork thin unicorn unicorn_rails)

## Functions

_bundler-installed() {
  which bundle > /dev/null 2>&1
}

_within-bundled-project() {
  local check_dir=$PWD
  while [ "$(dirname $check_dir)" != "/" ]; do
    [ -f "$check_dir/Gemfile" ] && return
    check_dir="$(dirname $check_dir)"
  done
  false
}

_bundled() {
  if _bundler-installed && _within-bundled-project; then
    return true
  fi

  false
}

_run-with-bundler() {
  if _bundled; then
    bundle exec $@
  else
    $@
  fi
}


# rake
## Main program
for cmd in $bundled_commands; do
  alias $cmd="_run-with-bundler $cmd"
done

# vim:set ft=zsh:
