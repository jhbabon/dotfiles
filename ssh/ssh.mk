# Always install ssh configuration files

INSTALLERS += ssh
CLEANERS   += clean_ssh

SSH_SRC_DIR := $(DOTFILES)/ssh
SSH_DST_DIR := $(DST_DIR)/.ssh
SSH_CONFIG  := $(SSH_DST_DIR)/config

.PHONY: ssh clean_ssh

ssh: banner_install_ssh $(SSH_CONFIG)

$(SSH_CONFIG): $(SSH_DST_DIR)
	$(LINK) $(SSH_SRC_DIR)/config $@

$(SSH_DST_DIR):
	$(MKDIR) $@

clean_ssh: banner_clean_ssh
	$(RM) $(SSH_CONFIG)
