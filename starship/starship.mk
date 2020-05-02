# Starship prompt manager: https://starship.rs
STARSHIP := $(shell command -v starship 2>/dev/null)

ifdef STARSHIP
INSTALLERS += starship
CLEANERS   += clean_starship

STARSHIP_SRC_DIR    := $(DOTFILES)/starship
STARSHIP_SRC_CONFIG := $(STARSHIP_SRC_DIR)/starship.toml
STARSHIP_DST_DIR    := $(CONFIG_DIR)
STARSHIP_DST_CONFIG := $(STARSHIP_DST_DIR)/starship.toml

.PHONY: starship clean_starship

starship: banner_install_starship $(STARSHIP_DST_CONFIG)

$(STARSHIP_DST_CONFIG):
	$(LINK) $(STARSHIP_SRC_CONFIG) $@

clean_starship: banner_clean_starship
	$(RM) $(STARSHIP_DST_CONFIG)

else
IGNORED += starship

endif
