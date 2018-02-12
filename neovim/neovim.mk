NEOVIM := $(shell command -v nvim 2>/dev/null)

ifdef NEOVIM
INSTALLERS += neovim
CLEANERS   += clean_neovim

NEOVIM_SRC_DIR  := $(DOTFILES)/neovim/nvim
NEOVIM_DST_DIR  := $(CONFIG_DIR)/nvim
NEOVIM_PLUG_URL := https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
NEOVIM_PLUG     := $(NEOVIM_DST_DIR)/autoload/plug.vim

.PHONY: neovim clean_neovim

neovim: banner_install_neovim $(NEOVIM_DST_DIR) $(NEOVIM_PLUG)

$(NEOVIM_DST_DIR):
	$(LINK) $(NEOVIM_SRC_DIR) $@

$(NEOVIM_PLUG): $(NEOVIM_DST_DIR)
	$(MKDIR) $(@D)
	curl -fLo $@ $(NEOVIM_PLUG_URL)
	nvim +PlugInstall +qa

clean_neovim: banner_clean_neovim
	$(RM) $(NEOVIM_PLUG)
	$(RM) $(NEOVIM_DST_DIR)

endif
