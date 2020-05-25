SCOUT := $(shell command -v scout 2>/dev/null)

ifdef SCOUT
INSTALLERS += scout
CLEANERS   += clean_scout

SCOUT_SRC_DIR    := $(DOTFILES)/scout
SCOUT_SRC_CONFIG := $(SCOUT_SRC_DIR)/scout.toml
SCOUT_DST_DIR    := $(CONFIG_DIR)
SCOUT_DST_CONFIG := $(SCOUT_DST_DIR)/scout.toml

.PHONY: scout clean_scout

scout: banner_install_scout $(SCOUT_DST_CONFIG)

$(SCOUT_DST_CONFIG):
	$(LINK) $(SCOUT_SRC_CONFIG) $@

clean_scout: banner_clean_scout
	$(RM) $(SCOUT_DST_CONFIG)

else
IGNORED += scout

endif
