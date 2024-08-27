#!/bin/bash

# exit when any command fails
set -e

###
# HOMEBREW
###
if [[ $(command -v brew) == "" ]]; then
    echo "Installing Hombrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Updating Homebrew"
    brew update
fi

brew analytics off

if [ -f "$HOME/dotfiles/Brewfile" ]; then
	echo "Updating homebrew bundle..."
	brew bundle --file="$HOME/dotfiles/Brewfile"
else
	echo "ERROR! Brewfile not found. Exiting..."
	exit
fi

brew upgrade
brew cleanup

###
# INITIALIZE DOTFILES
###
echo 'Stowing all dotfiles...'
stow */

echo 'Starting Fish and installing plugins...'
fish
fisher update

echo 'Installing global node packages...'
npm install -g neovim tldr

echo 'Installing Rust...'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fish_add_path ~/.cargo/bin

echo 'Installing Bun...'
curl -fsSL https://bun.sh/install | bash
