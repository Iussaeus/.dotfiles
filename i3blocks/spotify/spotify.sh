#!/bin/sh
status=$(playerctl -p spotify status)
if [ $status != "Paused" ]; then
	current_time_s=$(playerctl position)
	minutes=$(echo "$current_time_s" | awk '{ printf "%d", $1 / 60 }')
	seconds=$(echo "$current_time_s" | awk '{ printf "%d", $1 % 60 }')

	title=$(playerctl -p spotify metadata title)
	artist=$(playerctl -p spotify metadata artist) 

	printf "%s - %s %d:%02d \n" "$artist" "$title" $minutes $seconds
else exit 1 
fi
