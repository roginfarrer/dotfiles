#!/bin/bash

update() {
	source "$HOME/.config/sketchybar/colors.sh"
	COLOR=$BACKGROUND_2
	if [ "$SELECTED" = "true" ]; then
		COLOR=$GREY
	fi
	sketchybar --set $NAME icon.highlight=$SELECTED label.highlight="$SELECTED" background.border_color=$COLOR
}

declare -A window_codes
window_codes['1']=18
window_codes['2']=19
window_codes['3']=20
window_codes['4']=21
window_codes['5']=23
window_codes['6']=22
window_codes['7']=27
window_codes['8']=28
window_codes['9']=25

mouse_clicked() {
	if [ "$BUTTON" = "right" ]; then
		yabai -m space --destroy $SID
		sketchybar --trigger windows_on_spaces --trigger space_change
	else
		# yabai -m space --focus $SID 2>/dev/null
		osascript -e "tell application \"System Events\" to key code ${window_codes[$SID]} using control down"
	fi
}

case "$SENDER" in
"mouse.entered")
	mouse_entered
	;;
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
