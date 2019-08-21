INSTALLERS += alacritty
CLEANERS   += clean_alacritty

ALACRITTY_SRC_DIR    := $(DOTFILES)/alacritty
ALACRITTY_DST_DIR    := $(CONFIG_DIR)/alacritty
ALACRITTY_SRC_CONFIG := $(ALACRITTY_SRC_DIR)/alacritty.yml
ALACRITTY_DST_CONFIG := $(ALACRITTY_DST_DIR)/alacritty.yml

.PHONY: alacritty clean_alacritty

alacritty: banner_install_alacritty $(ALACRITTY_DST_CONFIG)

$(ALACRITTY_DST_CONFIG): $(ALACRITTY_DST_DIR)
	$(LINK) $(ALACRITTY_SRC_CONFIG) $@

$(ALACRITTY_DST_DIR):
	$(MKDIR) $@

clean_alacritty: banner_clean_alacritty
	$(RM) $(ALACRITTY_DST_CONFIG)
