ASDF := $(shell command -v asdf 2>/dev/null)

ifdef ASDF
INSTALLERS += asdf
CLEANERS   += clean_asdf

ASDF_SRC_DIR         := $(DOTFILES)/asdf
ASDF_DST_DIR         := $(DST_DIR)
ASDF_SRC_CONFIG      := $(ASDF_SRC_DIR)/asdfrc
ASDF_DST_CONFIG      := $(ASDF_DST_DIR)/.asdfrc
ASDF_SRC_RUBY_CONFIG := $(ASDF_SRC_DIR)/default-gems
ASDF_DST_RUBY_CONFIG := $(ASDF_DST_DIR)/.default-gems

.PHONY: asdf clean_asdf

asdf: banner_install_asdf $(ASDF_DST_CONFIG) $(ASDF_DST_RUBY_CONFIG)

$(ASDF_DST_CONFIG):
	$(LINK) $(ASDF_SRC_CONFIG) $@

$(ASDF_DST_RUBY_CONFIG):
	$(LINK) $(ASDF_SRC_RUBY_CONFIG) $@

clean_asdf: banner_clean_asdf
	$(RM) $(ASDF_DST_CONFIG)

endif
