NEOVIM := $(shell command -v nvim 2>/dev/null)

ifdef NEOVIM
INSTALLERS += neovim
CLEANERS   += clean_neovim

NEOVIM_SRC_DIR := $(DOTFILES)/neovim/nvim
NEOVIM_DST_DIR := $(CONFIG_DIR)/nvim
NEOVIM_PAQ_URL := https://github.com/savq/paq-nvim.git
NEOVIM_PAQ_DST := $(NEOVIM_DST_DIR)/pack/paqs
NEOVIM_PAQ_OPT := $(NEOVIM_PAQ_DST)/opt/paq-nvim

.PHONY: neovim clean_neovim

neovim: banner_install_neovim $(NEOVIM_DST_DIR) $(NEOVIM_PAQ_DST)

$(NEOVIM_DST_DIR):
	$(LINK) $(NEOVIM_SRC_DIR) $@

$(NEOVIM_PAQ_DST):
	$(CLONE) $(NEOVIM_PAQ_URL) $(NEOVIM_PAQ_OPT)
	# nvim +PackBootstrap

clean_neovim: banner_clean_neovim
	$(RM) $(NEOVIM_PAQ_DST)
	$(RM) $(NEOVIM_DST_DIR)

else
IGNORED += neovim

endif
