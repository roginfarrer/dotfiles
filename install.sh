#!/bin/bash

###
# HOMEBREW
###
if ! command -v brew >/dev/null 2>&1; then
	echo "Installing homebrew"
	export HOMEBREW_BREW_GIT_REMOTE="..." # put your Git mirror of Homebrew/brew here
	export HOMEBREW_CORE_GIT_REMOTE="..." # put your Git mirror of Homebrew/homebrew-core here
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
