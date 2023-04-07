#!/usr/bin/env sh

DEVICES=$(system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null | jq '.SPBluetoothDataType[0].device_connected[]? | select( .[] | .device_minorType == "Headphones") | keys[]')

if [ "$DEVICES" = "" ]; then
	sketchybar --set $NAME icon.drawing=off background.padding_right=0 background.padding_left=0 label=""
else
	sketchybar --set $NAME icon.drawing=on background.padding_right=1 background.padding_left=4 label="$DEVICES"
fi
