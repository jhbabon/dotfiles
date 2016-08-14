# Use nodejs-install and direnv to manage node versions.
if test (which nodejs-install ^ /dev/null);
  set -x NODE_HOME $HOME/.local/share/node
  set -x NODE_VERSIONS $NODE_HOME/versions
end
