I3 := $(shell command -v i3 2>/dev/null)

ifdef I3
INSTALLERS += i3
CLEANERS   += clean_i3

I3_SRC_DIR      := $(DOTFILES)/i3
I3_CONFIG       := $(CONFIG_DIR)/i3/config
I3STATUS_CONFIG := $(CONFIG_DIR)/i3status/config
I3SYSTEM        := $(DST_DIR)/.local/bin/i3system
I3UDISK         := $(DST_DIR)/.local/bin/i3udisk

.PHONY: i3 clean_i3

i3: banner_install_i3 $(I3SYSTEM) $(I3UDISK) $(I3_CONFIG) $(I3STATUS_CONFIG)

$(DST_DIR)/.local/bin/%:
	$(MKDIR) $(@D)
	$(LINK) $(I3_SRC_DIR)/$* $@

$(I3_CONFIG):
	$(MKDIR) $(@D)
	$(LINK) $(I3_SRC_DIR)/i3.conf $@

$(I3STATUS_CONFIG):
	$(MKDIR) $(@D)
	$(LINK) $(I3_SRC_DIR)/i3status.conf $@

clean_i3: banner_clean_i3
	$(RM) $(I3SYSTEM)
	$(RM) $(I3UDISK)
	$(RM) $(I3_CONFIG)
	$(RM) $(I3STATUS_CONFIG)

endif

# vim:set ft=make:
