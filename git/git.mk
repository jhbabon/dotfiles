GIT := $(shell command -v git 2>/dev/null)

ifdef GIT
INSTALLERS += git
CLEANERS   += clean_git

GIT_SRC_DIR       := $(DOTFILES)/git
GIT_DST_DIR       := $(CONFIG_DIR)/git
GIT_SRC_CONFIG    := $(GIT_SRC_DIR)/gitconfig
GIT_DST_CONFIG    := $(DST_DIR)/.gitconfig
GIT_TEMPLATE_REPO := https://github.com/jhbabon/git-template.git
GIT_TEMPLATE_DIR  := $(GIT_DST_DIR)/template

.PHONY: git clean_git

git: banner_install_git $(GIT_DST_CONFIG) $(GIT_TEMPLATE_DIR)

$(GIT_DST_CONFIG):
	$(LINK) $(GIT_SRC_CONFIG) $@

$(GIT_TEMPLATE_DIR): $(GIT_DST_DIR)
	$(CLONE) $(GIT_TEMPLATE_REPO) $(GIT_SRC_DIR)/template
	$(LINK) $(GIT_SRC_DIR)/template $@


$(GIT_DST_DIR):
	$(MKDIR) $@

clean_git: banner_clean_git
	$(RM) $(GIT_TEMPLATE_DIR)
	$(RM) $(GIT_SRC_DIR)/template
	$(RM) $(GIT_DST_DIR)
	$(RM) $(GIT_DST_CONFIG)

else
IGNORED += git

endif
