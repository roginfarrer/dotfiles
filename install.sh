#!/bin/bash

###
# HOMEBREW
###
if ! command -v brew >/dev/null 2>&1; then
	echo "Installing homebrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

brew analytics off

if [ -f "$HOME/Brewfile" ]; then
	echo "Updating homebrew bundle"
	brew bundle --global
fi

brew upgrade
brew cleanup

###
# INITIALIZE DOTFILES
###
stow *

###
# INITIALIZE FISH
###
fish
fisher update

npm install -g @fsouza/prettierd neovim eslint_d lua-fmt tldr
