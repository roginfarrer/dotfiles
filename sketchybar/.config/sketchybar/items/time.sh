#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

time=(
    update_freq=1
    # script="$PLUGIN_DIR/time.sh"
    script="sketchybar --set \$NAME label=\"\$(date '+%I:%M %p')\""
    click_script="$POPUP_CLICK_SCRIPT"
    label.padding_left=20
    label.padding_right=15
    background.corner_radius=10
    background.color=$TEMPUS
    background.height=$BG_HEIGHT
    background.padding_left=-10
    background.padding_right=3
    padding_right=0
)

time_popup=(
    icon=$TIME
    icon.padding_left=10
    label="$(date '+%H:%M:%S')"
    label.padding_left=10
    label.padding_right=10
    label.font="SF Pro:Bold:12.0"
    # height=10
    blur_radius=100
)

sketchybar --add item time right \
    --set time "${time[@]}" \
    --subscribe time system_woke

sketchybar --add item time.popup popup.time \
    --set time.popup "${time_popup[@]}"

