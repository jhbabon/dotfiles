RBENV := $(shell command -v rbenv 2>/dev/null)

ifdef RBENV
INSTALLERS += rbenv
CLEANERS   += clean_rbenv

RBENV_SRC_DIR          := $(DOTFILES)/rbenv
RBENV_DST_DIR          := $(shell rbenv root)
RBENV_SRC_DEFAULT_GEMS := $(RBENV_SRC_DIR)/default-gems
RBENV_DST_DEFAULT_GEMS := $(RBENV_DST_DIR)/default-gems

.PHONY: rbenv clean_rbenv

rbenv: banner_install_rbenv $(RBENV_DST_DEFAULT_GEMS)

$(RBENV_DST_DEFAULT_GEMS):
	$(LINK) $(RBENV_SRC_DEFAULT_GEMS) $@
	@echo "--> Post install: install the rbenv-default-gems plugin to use the default-gems file"

clean_rbenv: banner_clean_rbenv
	$(RM) $(RBENV_DST_DEFAULT_GEMS)

endif
