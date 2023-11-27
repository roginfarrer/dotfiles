#!/bin/sh

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

sketchybar --set $NAME label="$(date '+%I:%M %p')"

time_popup=(
    icon=$TIME
    icon.padding_left=10
    label="$(date '+%I:%M %p')"
    label.padding_left=10
    label.padding_right=10
    label.font="SF Pro:Bold:12.0"
    height=10
    blur_radius=100
)


safe_add() {
    sketchybar --query $1 >/dev/null 2>&1
    [ "$?" -eq "1" ] && sketchybar --add item $1
}

safe_add "time.popup popup.time"

sketchybar --set time.popup "${time_popup[@]}"
