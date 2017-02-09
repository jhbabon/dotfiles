ZSH := $(shell command -v zsh 2>/dev/null)

ifdef ZSH
INSTALLERS += zsh
CLEANERS   += clean_zsh

Z_SRC_DIR    := $(DOTFILES)/zsh
ZCONFIG_DIR  := $(CONFIG_DIR)/zsh
ANTIGEN_DIR  := $(ZCONFIG_DIR)/antigen
ANTIGEN_REPO := https://github.com/zsh-users/antigen.git
ZDOT_DIR     := $(DST_DIR)
ZRC_DIR      := $(ZCONFIG_DIR)/rc.d
ZENV_DIR     := $(ZCONFIG_DIR)/env.d
ZSHRC        := $(ZDOT_DIR)/.zshrc
ZSHENV       := $(ZDOT_DIR)/.zshenv
ZPROFILE     := $(ZDOT_DIR)/.zprofile
ZCACHE_DIR   := $(DST_DIR)/.cache/zsh

.PHONY: zsh clean_zsh

zsh: banner_install_zsh $(ZCACHE_DIR) $(ZENV_DIR) $(ZRC_DIR) $(ANTIGEN_DIR) $(ZSHENV) $(ZSHRC) $(ZPROFILE)

$(ZPROFILE):
	$(LINK) $(Z_SRC_DIR)/zprofile $@

$(ZSHENV):
	$(LINK) $(Z_SRC_DIR)/zshenv $@

$(ZSHRC):
	$(LINK) $(Z_SRC_DIR)/zshrc $@

$(ZENV_DIR) $(ZRC_DIR): $(ZCONFIG_DIR)
	$(LINK) $(Z_SRC_DIR)/$(@F) $@

$(ANTIGEN_DIR): $(ZCONFIG_DIR)
	$(CLONE) $(ANTIGEN_REPO) $@

$(ZCONFIG_DIR):
	$(MKDIR) $@

$(ZCACHE_DIR):
	$(MKDIR) $@

clean_zsh: banner_clean_zsh
	$(RM) $(DST_DIR)/.antigen
	$(RM) $(ZCONFIG_DIR)
	$(RM) $(ZSHENV)
	$(RM) $(ZSHRC)
endif
