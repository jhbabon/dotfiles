NEOVIM := $(shell command -v nvim 2>/dev/null)

ifdef NEOVIM
INSTALLERS += neovim
CLEANERS   += clean_neovim

NEOVIM_SRC_DIR    := $(DOTFILES)/neovim/nvim
NEOVIM_DST_DIR    := $(CONFIG_DIR)/nvim
NEOVIM_MINPAC_URL := https://github.com/k-takata/minpac.git
NEOVIM_MINPAC_DST := $(NEOVIM_DST_DIR)/pack/minpac
NEOVIM_MINPAC_OPT := $(NEOVIM_MINPAC_DST)/opt/minpac

.PHONY: neovim clean_neovim

neovim: banner_install_neovim $(NEOVIM_DST_DIR) $(NEOVIM_MINPAC_DST)

$(NEOVIM_DST_DIR):
	$(LINK) $(NEOVIM_SRC_DIR) $@

$(NEOVIM_MINPAC_DST):
	$(CLONE) $(NEOVIM_MINPAC_URL) $(NEOVIM_MINPAC_OPT)
	nvim +PackBootstrap

clean_neovim: banner_clean_neovim
	$(RM) $(NEOVIM_MINPAC_DST)
	$(RM) $(NEOVIM_DST_DIR)

else
IGNORED += neovim

endif
