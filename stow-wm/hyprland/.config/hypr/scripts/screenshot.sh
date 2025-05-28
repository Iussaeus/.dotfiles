#!/bin/bash

# Checking and installing dependencies
dependencies=("slurp" "grim" "convert" "swappy")
for dep in "${dependencies[@]}"; do
    command -v "$dep" &> /dev/null || { echo "$dep not found, please install it."; exit 1; }
done

# Capture screenshot
screenshot="$(slurp)"

# Process the screenshot and copy to clipboard
grim -g "$screenshot" - | magick - -shave 2x2 PNG:- | wl-copy

# Paste to clipboard and use swappy for further processing
wl-paste | swappy -f -
