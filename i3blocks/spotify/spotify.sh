#!/bin/bash
status=$(playerctl -p spotify status)
if [ "$status" == "Playing" ];  then
	metadata=$(playerctl -p spotify metadata --format "{{artist}} - {{title}} {{duration(position)}}")
	echo $metadata
fi
