ZSH := $(shell command -v zsh 2>/dev/null)

ifdef ZSH
INSTALLERS += zsh
CLEANERS   += clean_zsh

Z_SRC_DIR    := $(DOTFILES)/zsh
ZCONFIG_DIR  := $(CONFIG_DIR)/zsh
ZDOT_DIR     := $(DST_DIR)
ZSHRC        := $(ZDOT_DIR)/.zshrc
ZSHENV       := $(ZDOT_DIR)/.zshenv
ZPROFILE     := $(ZDOT_DIR)/.zprofile
ZCACHE_DIR   := $(DST_DIR)/.cache/zsh

ZPLUGINS_DST_DIR  := $(ZCONFIG_DIR)/plugins
ZPLUGINS_SH_DIR   := $(ZPLUGINS_DST_DIR)/zsh-syntax-highlighting
ZPLUGINS_SH_REPO  := https://github.com/zsh-users/zsh-syntax-highlighting.git
ZPLUGINS_AS_DIR   := $(ZPLUGINS_DST_DIR)/zsh-autosuggestions
ZPLUGINS_AS_REPO  := https://github.com/zsh-users/zsh-autosuggestions.git
ZPLUGINS_HSS_DIR  := $(ZPLUGINS_DST_DIR)/zsh-history-substring-search
ZPLUGINS_HSS_REPO := https://github.com/zsh-users/zsh-history-substring-search.git

ZPROMPT := $(ZCONFIG_DIR)/prompt.zsh


.PHONY: zsh clean_zsh

zsh: banner_install_zsh $(ZCACHE_DIR) $(ZSHENV) $(ZSHRC) $(ZPROFILE) zplugins

$(ZSHENV):
	$(LINK) $(Z_SRC_DIR)/zshenv $@

$(ZSHRC): $(ZPROMPT)
	$(LINK) $(Z_SRC_DIR)/zshrc $@

$(ZPROFILE):
	$(LINK) $(Z_SRC_DIR)/zprofile $@

$(ZPROMPT):
	$(LINK) $(Z_SRC_DIR)/prompt.zsh $@

zplugins: $(ZPLUGINS_SH_DIR) $(ZPLUGINS_AS_DIR) $(ZPLUGINS_HSS_DIR)

$(ZPLUGINS_SH_DIR): $(ZPLUGINS_DST_DIR)
	$(CLONE) $(ZPLUGINS_SH_REPO) $@

$(ZPLUGINS_AS_DIR): $(ZPLUGINS_DST_DIR)
	$(CLONE) $(ZPLUGINS_AS_REPO) $@

$(ZPLUGINS_HSS_DIR): $(ZPLUGINS_DST_DIR)
	$(CLONE) $(ZPLUGINS_HSS_REPO) $@

$(ZPLUGINS_DST_DIR): $(ZCONFIG_DIR)
	$(MKDIR) $@

$(ZCONFIG_DIR):
	$(MKDIR) $@

$(ZCACHE_DIR):
	$(MKDIR) $@

clean_zsh: banner_clean_zsh
	$(RM) $(ZPLUGINS_DST_DIR)
	$(RM) $(ZSHENV)
	$(RM) $(ZSHRC)
	$(RM) $(ZPROFILE)
	$(RM) $(ZPROMPT)

else
IGNORED += zsh
endif
