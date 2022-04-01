#!/bin/bash

# exit when any command fails
set -e

###
# XCODE
###
echo "Installing xcode-stuff"
xcode-select --install

###
# HOMEBREW
###
if test ! $(which brew); then
	echo "Installing homebrew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew analytics off

if [ -f "$HOME/dotfiles/brew/Brewfile" ]; then
	echo "Updating homebrew bundle..."
	brew bundle --file="$HOME/dotfiles/brew/Brewfile"
else
	echo "ERROR! Brewfile not found. Exiting..."
	exit
fi

brew upgrade
brew cleanup

###
# INITIALIZE DOTFILES
###
stow */

###
# INITIALIZE FISH
###
fish
fisher update

npm install -g @fsouza/prettierd neovim eslint_d lua-fmt tldr
