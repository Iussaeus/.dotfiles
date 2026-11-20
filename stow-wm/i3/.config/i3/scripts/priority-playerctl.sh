#!/usr/bin/env bash

while IFS= read -r player; do
    player_status=$(playerctl -p "$player" status 2>/dev/null)

    if [[ "$player_status" == "Playing" ]]; then
        exec playerctl -p "$player" "$@"
    fi
done < <(playerctl -l)

exec playerctl "$@"
