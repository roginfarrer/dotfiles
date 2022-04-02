#!/bin/bash

# exit when any command fails
set -e

###
# HOMEBREW
###
if test ! $(which brew); then
	echo "Installing homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
echo 'Stowing fish, nvim, kitty...'
stow fish nvim kitty

echo 'Starting Fish and installing plugins...'
fish
fisher update

echo 'Installing global node packages...'
npm install -g @fsouza/prettierd neovim eslint_d tldr

echo 'Installing Rust...'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fish_add_path ~/.cargo/bin

echo 'Installing crates...'
cargo install stylua
