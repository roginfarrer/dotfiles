#!/bin/bash

volume=(
    script="$PLUGIN_DIR/volume.sh"
    updates=on
    label.drawing=off
    icon.drawing=off
    slider.highlight_color=$PURPLE
    slider.background.height=5
    slider.background.corner_radius=3
    slider.background.color=$GREY
    slider.knob=$DOT
    slider.knob.drawing=off
    label.padding_right=10
    label.padding_left=10
    background.color=$STATUS
    background.height=10
    background.corner_radius=10
    background.border_width=2
    background.border_color=$PURPLE
    background.padding_right=7
)

volume_icon=(
    click_script="$PLUGIN_DIR/volume_click.sh"
    label.padding_right=8
    label.padding_left=12
)

sketchybar --add slider volume right \
    --set volume "${volume[@]}" \
    --subscribe volume volume_change mouse.clicked mouse.entered mouse.exited

sketchybar --add item volume_icon right \
    --set volume_icon "${volume_icon[@]}"
