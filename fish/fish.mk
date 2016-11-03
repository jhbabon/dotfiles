# Disable fish shell
# FISH := $(shell command -v fish 2>/dev/null)

ifdef FISH
INSTALLERS += fish
CLEANERS   += clean_fish

FISH_SRC_DIR  := $(DOTFILES)/fish
FISH_DST_DIR  := $(CONFIG_DIR)/fish
FISH_CONF_DIR := $(FISH_DST_DIR)/conf.d
FISH_FUNC_DIR := $(FISH_DST_DIR)/functions
BASHRC        := $(DST_DIR)/.bashrc

.PHONY: fish clean_fish

fish: banner_install_fish $(FISH_CONF_DIR) $(FISH_FUNC_DIR) $(BASHRC)

$(FISH_CONF_DIR): $(FISH_DST_DIR)
	$(LINK) $(FISH_SRC_DIR)/conf.d $@

$(FISH_FUNC_DIR): $(FISH_DST_DIR)
	$(LINK) $(FISH_SRC_DIR)/functions $@

$(FISH_DST_DIR):
	$(MKDIR) $@

$(BASHRC):
	$(LINK) $(FISH_SRC_DIR)/bashrc $@

clean_fish: banner_clean_fish
	$(RM) $(FISH_CONF_DIR)
	$(RM) $(FISH_FUNC_DIR)
	$(RM) $(FISH_DST_DIR)
	$(RM) $(BASHRC)

endif
