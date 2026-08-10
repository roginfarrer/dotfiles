# command -q mise && mise activate fish | source

# Hopefully prevents Mise from unexpectedly activating?
set -e MISE_SHELL
set -e __MISE_DIFF
set -e __MISE_SESSION
set -e __MISE_ORIG_PATH
