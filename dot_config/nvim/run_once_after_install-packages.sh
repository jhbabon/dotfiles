#!/usr/bin/env sh

set -e

echo "Installing: nvim plugins ********************"
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
