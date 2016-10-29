INSTALLERS += ruby
CLEANERS   += clean_ruby

RUBY_SRC_DIR := $(DOTFILES)/ruby
RUBY_IRBRC   := $(DST_DIR)/.irbrc
RUBY_BUNDLE  := $(DST_DIR)/.bundle

.PHONY: ruby clean_ruby

ruby: banner_install_ruby $(RUBY_IRBRC) $(RUBY_BUNDLE)

$(RUBY_IRBRC):
	$(LINK) $(RUBY_SRC_DIR)/irbrc $@

$(RUBY_BUNDLE):
	$(LINK) $(RUBY_SRC_DIR)/bundle $@

clean_ruby: banner_clean_ruby
	$(RM) $(RUBY_IRBRC)
	$(RM) $(RUBY_BUNDLE)
