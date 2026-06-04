#!/bin/bash

# First check OS.
OS="$(uname)"
if [[ "${OS}" == "Linux" ]]; then
    HOMEBREW_ON_LINUX=1
elif [[ "${OS}" == "Darwin" ]]; then
    HOMEBREW_ON_MACOS=1
else
    abort "Homebrew is only supported on macOS and Linux."
fi

# Determine Homebrew prefix
arch="$(uname -m)"
if [ "$arch" = "arm64" ]; then
    HOMEBREW_PREFIX="/opt/homebrew"
else
    HOMEBREW_PREFIX="/usr/local"
fi

case "${SHELL}" in
*/bash*)
    if [[ -n "${HOMEBREW_ON_LINUX-}" ]]; then
        shell_rcfile="${HOME}/.bashrc"
    else
        shell_rcfile="${HOME}/.bash_profile"
    fi
    ;;
*/zsh*)
    if [[ -n "${HOMEBREW_ON_LINUX-}" ]]; then
        shell_rcfile="${ZDOTDIR:-"${HOME}"}/.zshrc"
    else
        shell_rcfile="${ZDOTDIR:-"${HOME}"}/.zprofile"
    fi
    ;;
*/fish*)
    shell_rcfile="${HOME}/.config/fish/config.fish"
    ;;
*)
    shell_rcfile="${ENV:-"${HOME}/.profile"}"
    ;;
esac

###
# HOMEBREW
###
if ! command -v brew >/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    export PATH="/opt/homebrew/bin:/home/linuxbrew/.linuxbrew/bin:/usr/local/bin"
    eval "$($HOMEBREW_PREFIX/brew shellenv)"

    echo >>${shell_rcfile}
    echo 'eval "\$(${HOMEBREW_PREFIX}/bin/brew shellenv)"' >>${shell_rcfile}
    eval "\$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
else
    echo "Homebrew already installed. Updating..."
    brew update --force
fi

brew analytics off

if [ -f "$HOME/dotfiles/Brewfile_vm" ]; then
    echo "Updating homebrew bundle..."
    brew bundle --file="$HOME/dotfiles/Brewfile_vm"
else
    echo "ERROR! Brewfile not found. Exiting..."
    exit 1
fi
brew cleanup

###
# INITIALIZE DOTFILES
###
if [ -d "$HOME/.config/fish" ]; then
    mv $HOME/.config/fish $HOME/.config/old-fish
fi

mkdir $HOME/.config/fish
touch $HOME/.config/fish/local-config.fish

if [ -f "$HOME/.gitconfig" ]; then
    mv $HOME/.gitconfig $HOME/.gitconfig_local
fi

###
# SELECT STOW DIRECTORIES
###

# select_directories

"Stowing files..."
stow git fish nvim zsh yazi ripgrep bat lazygit mise lf starship tmux

echo 'Starting Fish and installing plugins...'
fish
fisher update

if command -v npm &>/dev/null; then
    echo 'Installing global node packages...'
    npm install -g neovim tldr
else
    echo "npm not found, skipping package installation"
fi

echo 'Installing Bob and Neovim...'
bob install stable
bob use stable
fish_add_path $HOME/.local/share/bob/nvim-bin

echo "Done!"
