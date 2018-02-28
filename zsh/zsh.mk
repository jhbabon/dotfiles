ZSH := $(shell command -v zsh 2>/dev/null)

ifdef ZSH
INSTALLERS += zsh
CLEANERS   += clean_zsh

Z_SRC_DIR    := $(DOTFILES)/zsh
ZCONFIG_DIR  := $(CONFIG_DIR)/zsh
ANTIGEN_DIR  := $(ZCONFIG_DIR)/antigen
ANTIGEN_REPO := https://github.com/zsh-users/antigen.git
ZDOT_DIR     := $(DST_DIR)
ZSHRC        := $(ZDOT_DIR)/.zshrc
ZSHENV       := $(ZDOT_DIR)/.zshenv
ZPROFILE     := $(ZDOT_DIR)/.zprofile
ZCACHE_DIR   := $(DST_DIR)/.cache/zsh

ZRC_SRC_DIR  := $(Z_SRC_DIR)/rc.d
ZENV_SRC_DIR := $(Z_SRC_DIR)/env.d
ZRC_DST_DIR  := $(ZCONFIG_DIR)/rc.d
ZENV_DST_DIR := $(ZCONFIG_DIR)/env.d

ZRC_SRC_FILES := $(wildcard $(ZRC_SRC_DIR)/*)
ZRC_DST_FILES := $(patsubst $(ZRC_SRC_DIR)/%, $(ZRC_DST_DIR)/%, $(ZRC_SRC_FILES))
ZENV_SRC_FILES := $(wildcard $(ZENV_SRC_DIR)/*)
ZENV_DST_FILES := $(patsubst $(ZENV_SRC_DIR)/%, $(ZENV_DST_DIR)/%, $(ZENV_SRC_FILES))

.PHONY: zsh clean_zsh

zsh: banner_install_zsh $(ZCACHE_DIR) $(ZENV_DST_FILES) $(ZRC_DST_FILES) $(ANTIGEN_DIR) $(ZSHENV) $(ZSHRC) $(ZPROFILE)

$(ZSHENV):
	$(LINK) $(Z_SRC_DIR)/zshenv $@

$(ZSHRC):
	$(LINK) $(Z_SRC_DIR)/zshrc $@

$(ZPROFILE):
	$(LINK) $(Z_SRC_DIR)/zprofile $@

$(ZENV_DST_FILES): $(ZENV_DST_DIR)
	$(LINK) $(ZENV_SRC_DIR)/$(@F) $@

$(ZRC_DST_FILES): $(ZRC_DST_DIR)
	$(LINK) $(ZRC_SRC_DIR)/$(@F) $@

$(ZENV_DST_DIR) $(ZRC_DST_DIR): $(ZCONFIG_DIR)
	$(MKDIR) $@

$(ANTIGEN_DIR): $(ZCONFIG_DIR)
	$(CLONE) $(ANTIGEN_REPO) $@

$(ZCONFIG_DIR):
	$(MKDIR) $@

$(ZCACHE_DIR):
	$(MKDIR) $@

clean_zsh: banner_clean_zsh
	$(RM) $(DST_DIR)/.antigen
	$(RM) $(ANTIGEN_DIR)
	$(RM) $(ZRC_DST_FILES)
	$(RM) $(ZENV_DST_FILES)
	$(RM) $(ZSHENV)
	$(RM) $(ZSHRC)
	$(RM) $(ZPROFILE)
endif
