#!/bin/bash

apple=(
    script="$PLUGIN_DIR/apple.sh"
    click_script="$POPUP_CLICK_SCRIPT"
    label=$APPLE
    label.padding_right=15
    label.padding_left=15
    background.color=$TEMPUS
    background.height=$BG_HEIGHT
    background.corner_radius=8
    background.padding_right=3
)

sketchybar --add item apple left \
    --set apple "${apple[@]}"
