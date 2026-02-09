#! /bin/env bash

full_line=$(pactl get-sink-volume @DEFAULT_SINK@)
row=$(echo $full_line | head -1)
col=$(echo $row | awk '{printf $5}')
vol=$(echo $col | tr -d %)

if [[ (( $vol -le 90 )) ]]; then
 pactl set-sink-volume @DEFAULT_SINK@ +10%
fi
