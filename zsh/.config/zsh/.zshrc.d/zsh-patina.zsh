if ! (( $+commands[zsh-patina] )); then
    echo "Zsh-patina is not installed. Installing..."
    brew install zsh-patina
    echo "zsh-patina installed. Please restart your terminal or source your .zshrc file."
fi
