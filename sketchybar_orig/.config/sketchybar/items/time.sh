#!/bin/bash

time=(
	label.align=right
	padding_left=0
	update_freq=30
	script="$PLUGIN_DIR/time.sh"
	click_script="$PLUGIN_DIR/zen.sh"
)

sketchybar --add item time right \
	--set time "${time[@]}" \
	--subscribe time system_woke
