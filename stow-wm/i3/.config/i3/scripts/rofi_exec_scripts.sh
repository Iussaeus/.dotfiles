#!/bin/env bash

all_entries=$(find "$HOME/.local/bin/" -type l -or -type f -executable)
selected=$(find "$HOME/.local/bin/" -type l -o -type f -executable | xargs -n1 basename | rofi -dmenu)
selected_full_path=$(grep $selected <<< "$all_entries")

if [ -n "$selected_full_path" ] && [ -e "$selected_full_path" ]; then
	terms=(kitty foot alacritty)
	for t in ${terms[*]}
	do
		if [ $(command -v $t) ]
		then
			detected_term=$t
			break
		fi
	done

	[ -n "$detected_term" ] && exec "$detected_term" -e "$selected_full_path"
fi
