# Helpers
# -----------------------------------------------

# mkcd:
#   * description: creates a dir and goes to it.
function mkcd() {
  mkdir -p "$1" && cd "$1";
}

# any:
#   * description: a very handy function from the Grml distro’s
#                  excellent zsh config that lets you search
#                  for running processes.
#   * link: http://onethingwell.org/post/14669173541/any
function any() {
  emulate -L zsh
  unsetopt KSH_ARRAYS
  if [[ -z "$1" ]] ; then
    echo "any - grep for process(es) by keyword" >&2
    echo "Usage: any <keyword>" >&2
    return 1
  else
    ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
  fi
}

# sf:
#   * description: create a .safe dir in $PWD to indicate
#                  that the bin dir in $PWD is secure to use.
function sf() {
  [[ -d $PWD/.safe ]] || (mkdir -p $PWD/.safe && echo '---> safe: done')
}

# explain:
#   * description: use the remote service explain.com from the terminal.
#   * link: https://github.com/schneems/explain_shell#without-rubygems
function explain() {
  # base url with first command already injected
  # $ explain tar
  #   => http://explainshel.com/explain/tar?args=
  url="http://explainshell.com/explain/$1?args="

  # removes $1 (tar) from arguments ($@)
  shift;

  # iterates over remaining args and adds builds the rest of the url
  for i in "$@"; do
    url=$url"$i""+"
  done

  # opens url in browser
  open $url
}

# weather:
#   * description: print the weather in the terminal using http://wttr.in
#   * usage:
#     weather [city]
#
#     $ weather
#     # => Prints Barcelona weather
#     $ weather Berlin
#     # => Prints Berlin weather
function weather() {
  local city="$1"
  [[ -z $city ]] && city="Barcelona"

  curl "http://wttr.in/$city"
}
