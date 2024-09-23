function has() {
    if command -v "$1" >/dev/null 2>&1; then
        return 0  # true
    else
        return 1  # false
    fi
}

