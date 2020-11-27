TMUX := $(shell command -v tmux 2>/dev/null)

ifdef TMUX
INSTALLERS += tmux
CLEANERS   += clean_tmux

TMUX_SRC_DIR  := $(DOTFILES)/tmux
TMUX_DST_DIR  := $(DST_DIR)/.tmux
TMUX_CONF     := $(DST_DIR)/.tmux.conf
TMUX_TPM_REPO := https://github.com/tmux-plugins/tpm.git
TMUX_TPM_DIR  := $(TMUX_DST_DIR)/plugins/tpm
TMUX_TERMINFO := $(TMUX_SRC_DIR)/tmux.terminfo

.PHONY: tmux clean_tmux

tmux: banner_install_tmux $(TMUX_CONF)

$(TMUX_CONF): terminfo $(TMUX_TPM_DIR)
	$(LINK) $(TMUX_SRC_DIR)/tmux.conf $@

terminfo:
	tic -x $(TMUX_TERMINFO)

$(TMUX_TPM_DIR): $(TMUX_DST_DIR)
	$(CLONE) $(TMUX_TPM_REPO) $(TMUX_TPM_DIR)
	@echo "--> To install TMUX plugins run in a session 'prefix + I'"

$(TMUX_DST_DIR):
	$(MKDIR) $@

clean_tmux: banner_clean_tmux
	$(RM) $(TMUX_DST_DIR)
	$(RM) $(TMUX_CONF)

else
IGNORED += tmux

endif
