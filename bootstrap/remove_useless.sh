#! /bin/env bash

dir_to_clean="$1"
filter_file="$2"

if [ -z "$dir_to_clean" ] || [ ! -d "$dir_to_clean" ]; then
	echo "Usage: $0 <directory_to_clean>"
	exit 1
fi

if [ -z "$filter_file" ]; then
	filter_file="$(realpath ./good_guys)"
fi

if [ ! -f "$(realpath $filter_file)" ]; then
    echo "Filter file '$filter_file' does not exist."
    exit 1
fi

if [[ "$dir_to_clean" == *"."* || "$dir_to_clean" == *".."* ]]; then
		dir_to_clean=$(realpath "$dir_to_clean")
fi

filtered_files=$(find "$dir_to_clean" -type f -not -wholename "$dir_to_clean" -not -name "$(basename $0)" -print0 | \
grep -z -v -F "good_guys" | \
grep -z -v -F -f "$filter_file" | \
xargs -0 echo)

if [ -n "$filtered_files" ]; then
	echo "$filtered_files" | xargs rm 
else
	echo "no files"
fi

filtered_dirs=$(find "$dir_to_clean" -type d -not -wholename "$dir_to_clean" -not -name "$(basename $0)" -print0 | \
grep -z -v -F "good_guys" | \
grep -z -v -F -f $filter_file | \
xargs -0 echo)

if [ -n "$filtered_dirs" ]; then
	echo "$filtered_dirs" | xargs rm -r 
else
	echo "no dirs"
fi
