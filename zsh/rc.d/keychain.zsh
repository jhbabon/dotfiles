# Run ssh-agents with keychain
cmd_exists keychain && eval `keychain --eval --noask --quiet id_rsa`
