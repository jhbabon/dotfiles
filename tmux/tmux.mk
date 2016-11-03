TMUX := $(shell command -v tmux 2>/dev/null)

ifdef TMUX
INSTALLERS += tmux
CLEANERS   += clean_tmux

TMUX_SRC_DIR  := $(DOTFILES)/tmux
TMUX_DST_DIR  := $(DST_DIR)/.tmux
TMUX_CONF     := $(DST_DIR)/.tmux.conf
TMUX_TPM_REPO := https://github.com/tmux-plugins/tpm.git
TMUX_TPM_DIR  := $(TMUX_DST_DIR)/plugins/tpm

.PHONY: tmux clean_tmux

tmux: banner_install_tmux $(TMUX_CONF) $(TMUX_DST_DIR) $(TMUX_TPM_DIR)

$(TMUX_CONF):
	$(LINK) $(TMUX_SRC_DIR)/tmux.conf $@

$(TMUX_DST_DIR):
	$(MKDIR) $@

$(TMUX_TPM_DIR):
	$(CLONE) $(TMUX_TPM_REPO) $(TMUX_TPM_DIR)
	@echo "--> Post install: To install TMUX plugins run in a session 'prefix + I'"

clean_tmux: banner_clean_tmux
	$(RM) $(TMUX_DST_DIR)
	$(RM) $(TMUX_CONF)

endif
