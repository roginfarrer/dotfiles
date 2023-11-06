#!/bin/sh

battery_popup=(
    icon.padding_left=10
    label.y_offset=0
    label.padding_left=10
    label.padding_right=10
    label.font="SF Pro:Bold:12.0"
    height=10
    blur_radius=100
)

safe_add() {
    sketchybar --query $1 &> /dev/null
    [[ $? -ne 0 ]] && sketchybar --add item $1
}

safe_add "battery.popup popup.battery"

sketchybar --set battery.popup "${battery_popup[@]}"

