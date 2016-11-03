TERMITE := $(shell command -v termite 2>/dev/null)

ifdef TERMITE
INSTALLERS += termite
CLEANERS   += clean_termite

TERMITE_SRC_DIR := $(DOTFILES)/termite
TERMITE_DST_DIR := $(CONFIG_DIR)/termite
TERMITE_CONF    := $(TERMITE_DST_DIR)/config

.PHONY: termite clean_termite

termite: banner_install_termite $(TERMITE_CONF)

$(TERMITE_CONF): $(TERMITE_DST_DIR)
	$(LINK) $(TERMITE_SRC_DIR)/config $@

$(TERMITE_DST_DIR):
	$(MKDIR) $@

clean_termite: banner_clean_termite
	$(RM) $(TERMITE_CONF)

endif
