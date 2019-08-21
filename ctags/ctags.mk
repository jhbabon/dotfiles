CTAGS := $(shell command -v ctags 2>/dev/null)

ifdef CTAGS
INSTALLERS += ctags
CLEANERS   += clean_ctags

CTAGS_SRC_DIR := $(DOTFILES)/ctags
CTAGS_CONF    := $(DST_DIR)/.ctags

.PHONY: ctags clean_ctags

ctags: banner_install_ctags $(CTAGS_CONF)

$(CTAGS_CONF):
	$(LINK) $(CTAGS_SRC_DIR)/ctags $@

clean_ctags: banner_clean_ctags
	$(RM) $(CTAGS_CONF)

else
IGNORED += ctags

endif
