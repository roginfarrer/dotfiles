#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

active_space=(
    icon=$PACMAN
    icon.color=$ACTIVE_SPACE_COLOR
)

reset_space=(
    icon=$GHOST
    icon.color=$ICON_COLOR
)

update() {
    if [ "$SELECTED" = "true" ]; then
        sketchybar --set $NAME "${active_space[@]}"
    else
        sketchybar --set $NAME "${reset_space[@]}"
    fi
}

# declare -A window_codes
window_codes['1']=18
window_codes['2']=19
window_codes['3']=20
window_codes['4']=21
window_codes['5']=23
window_codes['6']=22
window_codes['7']=27
window_codes['8']=28
window_codes['9']=25

mouse_clicked() {
    if [ "$BUTTON" = "right" ]; then
        yabai -m space --destroy $SID
        sketchybar --trigger windows_on_spaces --trigger space_change
    else
        yabai -m space --focus $SID || osascript -e "tell application \"System Events\" to key code ${window_codes[$SID]} using control down"
    fi
}

case "$SENDER" in
    "mouse.entered")
        mouse_entered
        ;;
    "mouse.exited")
        mouse_exited
        ;;
    "mouse.clicked")
        mouse_clicked
        ;;
    *)
        update
        ;;
esac
