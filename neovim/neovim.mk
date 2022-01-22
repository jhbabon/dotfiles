NEOVIM := $(shell command -v nvim 2>/dev/null)

ifdef NEOVIM
INSTALLERS += neovim
CLEANERS   += clean_neovim

NEOVIM_SRC_DIR    := $(DOTFILES)/neovim/nvim
NEOVIM_DST_DIR    := $(CONFIG_DIR)/nvim
NEOVIM_PACKER_URL := https://github.com/wbthomason/packer.nvim
NEOVIM_PACKER_DST := $(HOME)/.local/share/nvim/site/pack/packer
NEOVIM_PACKER_LD  := $(NEOVIM_DST_DIR)/lua/packer_compiled.lua

.PHONY: neovim clean_neovim

neovim: banner_install_neovim $(NEOVIM_DST_DIR) $(NEOVIM_PACKER_DST)

$(NEOVIM_DST_DIR):
	$(LINK) $(NEOVIM_SRC_DIR) $@

$(NEOVIM_PACKER_DST):
	$(CLONE) $(NEOVIM_PACKER_URL) $(NEOVIM_PACKER_DST)/opt/packer.nvim
	nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
	nvim --headless -c 'TSInstallSync maintained' +q

clean_neovim: banner_clean_neovim
	$(RM) $(NEOVIM_PACKER_LD)
	$(RM) $(NEOVIM_PACKER_DST)
	$(RM) $(NEOVIM_DST_DIR)

else
IGNORED += neovim

endif
