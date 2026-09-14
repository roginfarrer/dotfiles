if command -v brew >/dev/null 2>&1; then
    BREW_PATH="$(command -v brew)"
elif [[ -x /opt/homebrew/bin/brew ]]; then
    BREW_PATH=/opt/homebrew/bin/brew
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    BREW_PATH=/home/linuxbrew/.linuxbrew/bin/brew
fi

if [[ -n "${BREW_PATH:-}" ]]; then
    eval "$("$BREW_PATH" shellenv)"
fi

FISH_PATH="$(command -v fish 2>/dev/null)"

if [[ -o interactive && -n "$FISH_PATH" && "${SHELL:-}" != "$FISH_PATH" ]]; then
    SHELL="$FISH_PATH" exec "$FISH_PATH"
fi

unset BREW_PATH FISH_PATH
