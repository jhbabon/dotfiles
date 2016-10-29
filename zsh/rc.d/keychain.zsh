# Run ssh-agents with keychain
command -v keychain > /dev/null && eval "$(keychain --eval --noask --quiet id_rsa)"
