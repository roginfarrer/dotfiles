#!/bin/bash

ram=(
    icon=$RAM
    icon.padding_left=15
    script="$PLUGIN_DIR/ram.sh"
    label.padding_right=15
    label.padding_left=10
    update_freq=60
    background.corner_radius=10
    background.color=$TEMPUS
    background.height=$BG_HEIGHT
    # background.border_color=$PURPLE
)

sketchybar --add item ram q \
    --set ram "${ram[@]}"

cpu=(
    icon=$CPU
    icon.padding_left=15
    script="$PLUGIN_DIR/cpu.sh"
    label.padding_left=10
    label.padding_right=15
    update_freq=60
)

sketchybar --add item cpu q \
    --set cpu "${cpu[@]}"
