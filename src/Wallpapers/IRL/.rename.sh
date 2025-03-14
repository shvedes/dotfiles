#!/bin/bash

for file in *.png *.jpg *.jpeg *.webp; do
    filename="${file%.*}"
    extension="${file##*.}"
    if [[ ! "$filename" =~ ^[0-9]{3}$ ]]; then
        i=1
        while [[ -e $(printf "%03d" $i).png ]]; do
            ((i++))
        done
        new_filename=$(printf "%03d" $i).png

        if [[ ! "$extension" == "png" ]]; then
            convert "$file" "${new_filename}" 2> /dev/null
            rm "$file" 2> /dev/null
        else
            mv "$file" "${new_filename}"
        fi

        echo "$file > $new_filename"
    fi
done
