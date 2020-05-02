# Makefile to install all dotfiles
#
# $ make # install all dotfiles
# $ make neovim # install neovim dotfiles
#
# $ make clean # uninstall all dotfiles
# $ make clean_neovim # uninstall neovim dotfiles

DOTFILES := $(PWD)
DST_DIR  := $(HOME)

# Use XDG_CONFIG_HOME env var if possible.
ifdef XDG_CONFIG_HOME
	CONFIG_DIR := $(XDG_CONFIG_HOME)
endif
CONFIG_DIR ?= $(DST_DIR)/.config

LINK  := ln -sf
MKDIR := mkdir -p
CLONE := git clone --depth 1
RM    := rm -fr

.PHONY: default install clean list

default: install

banner_install_%:
	@echo ""
	@echo "+ Installing $* files"

banner_clean_%:
	@echo ""
	@echo "- Removing $* files"

include **/*.mk

install: $(INSTALLERS)

clean: $(CLEANERS)

list: list_installers_preface $(addprefix item_,$(INSTALLERS)) list_ignored_preface $(addprefix item_,$(IGNORED))

list_installers_preface:
	@echo "> Configuration files that can be installed"

list_ignored_preface:
	@echo ""
	@echo "> Configuration files that are ignored (reason: software not found)"

item_%:
	@echo "  * $*"
