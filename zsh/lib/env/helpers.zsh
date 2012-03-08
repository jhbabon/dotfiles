#!/usr/bin/env zsh

# helper functions

# any:
#   * description: A very handy function from the Grml distro’s
#                  excellent zsh config that lets you search
#                  for running processes.
#   * link: http://onethingwell.org/post/14669173541/any

any() {
  emulate -L zsh
  unsetopt KSH_ARRAYS
  if [[ -z "$1" ]] ; then
    echo "any - grep for process(es) by keyword" >&2
    echo "Usage: any " >&2 ; return 1
  else
    ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
  fi
}


# fp:
#   * description: find and list processes matching a
#                  case-insensitive partial-match string
#   * link: http://brettterpstra.com/fk-redux/
fp() {
  ps Ao pid,comm |\
    awk '{match($0,/[^\/]+$/); print substr($0,RSTART,RLENGTH)": "$1}'|\
    grep -i $1|\
    grep -v grep
}

# fk:
#   * description: kill the selected process matching the given param
#   * link: http://brettterpstra.com/fk-redux/
fk() {
  IFS=$'\n'
  PS3='Kill which process? (1 to cancel): '
  select OPT in "Cancel" $(fp $1); do
    if [ $OPT != "Cancel" ]; then
      kill $(echo $OPT|awk '{print $NF}')
    fi
    break
  done
  unset IFS
}

# randompass:
#   * description: small random password generator.
#   * params: a integer with the length of the password (default: 8).
#   * link: http://blog.leenix.co.uk/2010/04/bashsh-random-stringpassword-generator.html
randompass() {
  local _length
  if [ $1 ]; then
    _length=$1
  else
    _length=8
  fi

  pass=</dev/urandom tr -dc A-Za-z0-9 | head -c $_length
  echo $pass
}

# vim:set ft=zsh:
