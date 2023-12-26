#!/bin/bash
#
source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

battery=(
    script="$PLUGIN_DIR/battery.sh"
    update_freq=120
    updates=on
    click_script="$POPUP_CLICK_SCRIPT"
    label.padding_left=15
)

battery_popup=(
    label="$PERCENTAGE %"
    label.y_offset=0
    label.padding_left=10
    label.padding_right=10
    label.font="SF Pro:Bold:12.0"
    # height=10
    blur_radius=100
)

sketchybar --add item battery right \
    --set battery "${battery[@]}" \
    --subscribe battery power_source_change system_woke

sketchybar --add item battery.popup popup.battery \
    --set battery.popup "${battery_popup[@]}"
