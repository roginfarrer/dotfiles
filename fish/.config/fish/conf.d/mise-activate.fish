# Use mise shims instead of `mise activate fish`: activation spawns `mise hook-env`
# on every shell start and prompt (~50 ms). Shims only need a PATH entry.
# This file shadows brew's vendor_conf.d/mise-activate.fish (same basename),
# which would otherwise activate mise a second time.
test -d $HOME/.local/share/mise/shims; and fish_add_path -g -m $HOME/.local/share/mise/shims
