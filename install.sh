#!/bin/zsh

###
# HOMEBREW
if [[ $(command -v brew) == "" ]]; then
  echo "Installing Hombrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [ -d "/opt/homebrew/bin/brew" ]; then
    BREW_DIR="/opt/homebrew/bin/brew"
  fi
  if [ -d "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    BREW_DIR="/home/linuxbrew/.linuxbrew/bin/brew"
  fi

  echo 'eval "$($BREW_DIR shellenv)"' >>$HOME/.zprofile
  eval "$($BREW_DIR shellenv)"
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
  exit 1
fi
brew cleanup

###
# INITIALIZE DOTFILES
###
mkdir -p $HOME/.config/fish/completions
mkdir $HOME/.config/fish/conf.d
mkdir $HOME/.config/fish/functions
mkdir $HOME/.config/fish/themes

touch $HOME/.config/fish/completions/.keep
touch $HOME/.config/fish/conf.d/.keep
touch $HOME/.config/fish/functions/.keep
touch $HOME/.config/fish/themes/.keep
touch $HOME/.config/fish/local-config.fish

###
# SELECT STOW DIRECTORIES
###
# Get list of directories
DIRS=($(find $HOME/dotfiles -maxdepth 1 -type d -not -path '*/\.*' -printf '%f\n' | sort))

# Remove the first element if it's empty (current directory)
if [[ -z "${DIRS[0]}" ]]; then
    DIRS=("${DIRS[@]:1}")
fi

# Prepare options for whiptail
MENU_ITEMS=()
for dir in "${DIRS[@]}"; do
    MENU_ITEMS+=("$dir" "" OFF)
done

# Use whiptail to create a checklist
SELECTED=$(whiptail --title "Stow Directories" \
    --checklist "Choose directories to stow:" 20 60 10 \
    "${MENU_ITEMS[@]}" \
    3>&1 1>&2 2>&3)

# Check if user cancelled
if [[ $? -ne 0 ]]; then
    echo "Operation cancelled."
    exit 1
fi

# Remove quotes from selected items
SELECTED=$(echo "$SELECTED" | tr -d '"')

# Stow the selected directories
for dir in $SELECTED; do
    echo "Stowing $dir..."
    stow "$dir"
done

# echo 'Stowing all dotfiles...'
# stow */

echo 'Starting Fish and installing plugins...'
fish
fisher update

echo 'Installing global node packages...'
npm install -g neovim tldr

echo 'Installing Rust...'
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fish_add_path ~/.cargo/bin

echo 'Installing Bob and Neovim...'
bob install nightly
bob use nightly
fish_add_path $HOME/.local/share/bob/nvim-bin

echo 'Installing Bun...'
curl -fsSL https://bun.sh/install | bash
