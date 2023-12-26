#!/bin/bash

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"
source "$HOME/.config/sketchybar/colors.sh"
FRONT_APP_SCRIPT='sketchybar --set $NAME label="$INFO"'

current_space=(
    icon.padding_left=8
    icon.padding_right=10
    background.color=$MIDNIGHT
    background.height=$BG_HEIGHT
    background.corner_radius=8
    # background.border_color=$TRANSPARENT
    # background.border_width=3
    background.padding_left=8
    script="$PLUGIN_DIR/front_app.sh"
    associated_display=active
)

space_popup=(
    icon.padding_left=10
    label.font="SF Pro:Bold:18.0"
    label.padding_left=10
    label.padding_right=10
    blur_radius=100
)

sketchybar --add item current_space left \
    --set current_space "${current_space[@]}" \
    --subscribe current_space front_app_switched mouse.clicked mouse.exited

sketchybar --add item space.popup popup.current_space \
    --set space.popup "${space_popup[@]}"
