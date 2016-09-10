# Makefile to install all dotfiles
#
# $ make # install all dotfiles
# $ make vim # install vim dotfiles
#
# $ make clean # uninstall all dotfiles
# $ make clean_vim # uninstall vim dotfiles

DOTFILES := ${PWD}
TARGET   := ${HOME}
CONFIG   := ${TARGET}/.config

LINK  := ln -s
MKDIR := mkdir -p
CLONE := git clone
RM    := rm

# VIM options
VIM      := $(shell which vim)
VIMRC    := ${DOTFILES}/vimrc
VIM_DIR  := ${DOTFILES}/vim
PLUG_URL := https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
PLUG     := ${TARGET}/.vim/autoload/plug.vim

# TMUX options
TMUX     := $(shell which tmux)
TMUXCONF := ${DOTFILES}/tmux.conf
TMUX_DIR := ${DOTFILES}/tmux
TPM_REPO := https://github.com/tmux-plugins/tpm.git
TPM_DIR  := ${TARGET}/.tmux/plugins/tpm

# GIT options
GIT               := $(shell which git)
GITCONF           := ${DOTFILES}/gitconfig
GIT_DIR           := ${DOTFILES}/git
GIT_TEMPLATE_REPO := https://github.com/jhbabon/git-template.git
GIT_TEMPLATE_DIR  := ${CONFIG}/git/template

# CTAGS options
CTAGS       := $(shell which ctags)
CTAGSCONFIG := ${DOTFILES}/ctags

# RUBY options
IRBRC       := ${DOTFILES}/irbrc
BUNDLER_DIR := ${DOTFILES}/bundle

# FISH options
FISH     := $(shell which fish)
FISH_DIR := ${DOTFILES}/fish

# TERMITE
TERMITE     := $(shell which termite)
TERMITE_DIR := ${DOTFILES}/termite

.PHONY: install
install: vim tmux git ctags ruby fish termite

.PHONY: vim
vim: ${VIMRC} ${VIM_DIR}
ifdef VIM
	@echo ""
	@echo "==> Installing vim files"
	${LINK} ${VIMRC} ${TARGET}/.vimrc
	${LINK} ${VIM_DIR} ${TARGET}/.vim
	curl -fLo ${PLUG} --create-dirs ${PLUG_URL}
	vim +PlugInstall +qa
endif

.PHONY: tmux
tmux: ${TMUXCONF}
ifdef TMUX
	@echo ""
	@echo "==> Installing tmux files"
	${MKDIR} ${TMUX_DIR}
	${LINK} ${TMUX_DIR} ${TARGET}/.tmux
	${LINK} ${TMUXCONF} ${TARGET}/.tmux.conf
	[ -d ${TPM_DIR} ] || ${CLONE} ${TPM_REPO} ${TPM_DIR}
	@echo "--> Post install: To install TMUX plugins run in a session 'prefix + I'"
endif

.PHONY: git
git: ${GITCONF}
ifdef GIT
	@echo ""
	@echo "==> Installing git files"
	${MKDIR} ${GIT_DIR}
	${LINK} ${GIT_DIR} ${CONFIG}/git
	[ -d ${GIT_TEMPLATE_DIR} ] || ${CLONE} ${GIT_TEMPLATE_REPO} ${GIT_TEMPLATE_DIR}
	${LINK} ${GITCONF} ${TARGET}/.gitconfig
endif

.PHONY: ctags
ctags: ${CTAGSCONFIG}
ifdef CTAGS
	@echo ""
	@echo "==> Installing ctags files"
	${LINK} ${CTAGSCONFIG} ${TARGET}/.ctags
endif

.PHONY: ruby
ruby: ${IRBRC} ${BUNDLER_DIR}
	@echo ""
	@echo "==> Installing ruby files"
	${LINK} ${IRBRC} ${TARGET}/.irbrc
	${LINK} ${BUNDLER_DIR} ${TARGET}/.bundle

.PHONY: fish
fish: ${FISH_DIR}
ifdef FISH
	@echo ""
	@echo "==> Installing fish files"
	${MKDIR} ${CONFIG}/fish
	${LINK} ${FISH_DIR}/conf.d ${CONFIG}/fish/conf.d
	${LINK} ${FISH_DIR}/functions ${CONFIG}/fish/functions
endif

.PHONY: termite
termite: ${TERMITE_DIR}
ifdef TERMITE
	@echo ""
	@echo "==> Installing termite files"
	${LINK} ${TERMITE_DIR} ${CONFIG}/termite
endif

.PHONY: clean
clean: clean_vim clean_tmux clean_git clean_ctags\
	clean_ruby clean_fish clean_termite

.PHONY: clean_vim
clean_vim:
	@echo ""
	@echo "==> Removing vim files"
	${RM} ${TARGET}/.vim/autoload/plug.vim
	${RM} ${TARGET}/.vim
	${RM} ${TARGET}/.vimrc

.PHONY: clean_tmux
clean_tmux:
	@echo ""
	@echo "==> Removing tmux files"
	${RM} ${TARGET}/.tmux
	${RM} ${TARGET}/.tmux.conf

.PHONY: clean_git
clean_git:
	@echo ""
	@echo "==> Removing git files"
	${RM} ${TARGET}/.gitconfig
	${RM} ${CONFIG}/git

.PHONY: clean_ctags
clean_ctags:
	@echo ""
	@echo "==> Removing ctags files"
	${RM} ${TARGET}/.ctags

.PHONY: clean_ruby
clean_ruby:
	@echo ""
	@echo "==> Removing ruby files"
	${RM} ${TARGET}/.irbrc
	${RM} ${TARGET}/.bundle

.PHONY: clean_fish
clean_fish:
	@echo ""
	@echo "==> Removing fish files"
	${RM} -fr ${BASE16_SHELL_DIR}
	${RM} ${CONFIG}/fish/conf.d
	${RM} ${CONFIG}/fish/functions

.PHONY: clean_termite
clean_termite:
	@echo ""
	@echo "==> Removing termite files"
	${RM} ${CONFIG}/termite
