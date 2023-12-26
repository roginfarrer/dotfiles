#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

meetingbar=(
    update_freq=3
    label.drawing=off
    icon.drawing=off
    background.color=$TEMPUS
    background.height=$BG_HEIGHT
    background.corner_radius=8
    background.padding_left=0
    background.padding_right=0
    click_script="osascript ~/.config/sketchybar/open_meetingbar.applescript"
)

sketchybar --add alias "MeetingBar,Item-0" right \
    --set "MeetingBar,Item-0" "${meetingbar[@]}"
