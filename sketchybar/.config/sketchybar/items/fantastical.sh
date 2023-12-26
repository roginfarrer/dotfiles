#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

fantastical=(
    update_freq=30
    alias.color=$WHITE
    background.color=$TEMPUS
    background.height=$BG_HEIGHT
    background.corner_radius=8
    update_freq=30
    background.padding_left=10
    click_script="open x-fantastical3://show/mini"
    # click_script="shortcuts run 'Get Upcoming Meeting link' | cat | xargs open"
)

fantastical_item="Fantastical Helper,Fantastical"

sketchybar --add alias "$fantastical_item" right \
    --set "$fantastical_item" "${fantastical[@]}" \
    --subscribe "$fantastical_item" system_woke mouse.entered
