#!/usr/bin/env bash

temp=(
	update_freq=900
	script="$PLUGIN_DIR/weather.sh"
)

sketchybar --add item weather right \
	--set weather "${temp[@]}" \
	--subscribe weather system_woke mouse.entered
