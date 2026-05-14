#!/bin/bash
# rename_images.sh - Remove dashes from image filenames

# Process current directory
for file in *-*.jpg *-*.png *-*.jpeg *-*.webp; do
    if [ -f "$file" ]; then
        newname=$(echo "$file" | sed 's/-//g')
        if [ "$file" != "$newname" ]; then
            mv -v "$file" "$newname"
            echo "Renamed: $file -> $newname"
        fi
    fi
done

echo "Done!"