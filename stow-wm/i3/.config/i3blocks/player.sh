#! /bin/env bash

priority_playerctl() {
    ../i3/scripts/priority-playerctl.sh "$@"
}

if [[ "$BLOCK_BUTTON" == 1 ]]; then
  priority_playerctl play-pause 
fi

priority_playerctl metadata --format "{{artist}} - {{title}} {{duration(position)}}"
