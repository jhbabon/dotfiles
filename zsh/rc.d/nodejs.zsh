if ( command -v nodejs-install > /dev/null 2>&1 ) ; then
  export NODE_HOME="$HOME/.local/share/node"
  export NODE_VERSIONS="$NODE_HOME/versions"
fi
