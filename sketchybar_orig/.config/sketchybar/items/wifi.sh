#!/bin/bash

sketchybar --add item wifi right \
	--set wifi script="$PLUGIN_DIR/wifi.sh" \
	icon=直 \
	--subscribe wifi wifi_change
