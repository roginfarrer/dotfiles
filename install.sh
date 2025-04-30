#!/bin/bash

SELECTED=""

# Function to select directories using whiptail
select_directories() {
    # Temporary file for storing results
    local resultfile=$(mktemp)

    # Get list of directories in the current working directory
    # Use find to get directories, sed to remove ./ prefix, sort alphabetically
    mapfile -t dirs < <(find . -maxdepth 1 -type d | sed 's|^\./||' | sort | grep -v '^\.$')

    # Check if no directories exist
    if [ ${#dirs[@]} -eq 0 ]; then
        whiptail --title "Error" --msgbox "No directories found in the current working directory." 10 50
        return 1
    fi

    # Prepare directory list for whiptail
    local menu_items=()
    for dir in "${dirs[@]}"; do
        menu_items+=("$dir" "" "OFF")
    done

    # Use whiptail to create checklist
    if whiptail --title "Select Directories" \
        --checklist "Choose directories (use space to select):" 20 60 15 \
        "${menu_items[@]}" 2>"$resultfile"; then

        # Read selected directories
        mapfile -t selected < <(cat "$resultfile" | tr -d '"')

        # Check if any directories were selected
        if [ ${#selected[@]} -eq 0 ]; then
            whiptail --title "Notification" --msgbox "No directories selected." 10 50
            return 1
        fi

        # Display selected directories in a message box
        SELECTED=$(printf '%s\n' "${selected[@]}" | tr '\n' ' ')
        whiptail --title "Selected Directories" \
            --msgbox "You selected:\n\n$SELECTED" 20 60
    else
        # User cancelled
        whiptail --title "Cancelled" --msgbox "Directory selection cancelled." 10 50
        return 1
    fi

    # Clean up temporary file
    rm -f "$resultfile"
}

###
# HOMEBREW
###
 # if [[ $(command -v brew) == "" ]]; then
   echo "Installing Hombrew"
   # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
 
#   if [ -d "/opt/homebrew/bin/brew" ]; then
#     BREW_DIR="/opt/homebrew/bin/brew"
#   else
# 	  echo -n "Brew bin directory? "
#     read brew_dir
#     BREW_DIR="$brew_dir"
#   fi
# 
#     echo >> $HOME/.profile
#     SHELL_ENV_RESULT=$($BREW_DIR/brew shellenv)
#     echo "$SHELL_ENV_RESULT" >> $HOME/.bashrc
#     eval "$SHELL_ENV_RESULT"
# else
#   echo "Updating Homebrew"
#   brew update
# fi
 
 brew analytics off
 
 #if [ -f "$HOME/dotfiles/Brewfile_vm" ]; then
 #  echo "Updating homebrew bundle..."
 #  brew bundle --file="$HOME/dotfiles/Brewfile_vm"
 #else
 #  echo "ERROR! Brewfile not found. Exiting..."
 #  exit 1
 #fi
 #brew cleanup

###
# INITIALIZE DOTFILES
###
if [ -d "$HOME/.config/fish" ]; then
	mv $HOME/.config/fish $HOME/.config/old-fish
fi
mkdir -p $HOME/.config/fish/completions
mkdir $HOME/.config/fish/conf.d
mkdir $HOME/.config/fish/functions
mkdir $HOME/.config/fish/themes

touch $HOME/.config/fish/completions/.keep
touch $HOME/.config/fish/conf.d/.keep
touch $HOME/.config/fish/functions/.keep
touch $HOME/.config/fish/themes/.keep
touch $HOME/.config/fish/local-config.fish

if [ -f "$HOME/.gitconfig" ]; then
	mv $HOME/.gitconfig $HOME/.gitconfig_local
fi

###
# SELECT STOW DIRECTORIES
###

select_directories

"Stowing $SELECTED..."
stow $SELECTED

# Stow the selected directories

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

