#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

CURRENT_SPACE_ICONS=("$WORK" "$BROWSER" "$MUSIC" "$UNI" "$MAIL" "$GENERAL" "$GENERAL" "$GENERAL" "$GENERAL")
ACTIVE_SPACE=$(yabai -m query --spaces --space | jq '.index')
CURRENT_APP_IN_SPACE=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true')

update() {
    sketchybar --set current_space icon=${CURRENT_SPACE_ICONS[$(($ACTIVE_SPACE - 1))]}

    sketchybar --set space.popup label="$CURRENT_APP_IN_SPACE" \
        icon=${CURRENT_SPACE_ICONS[$(($ACTIVE_SPACE - 1))]}
}

mouse_clicked() {
    sketchybar --set current_space popup.drawing="toggle"
}

mouse_exited() {
    sketchybar --set current_space popup.drawing=false
}

case "$SENDER" in
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
