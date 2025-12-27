#!/bin/bash

# Default to current directory if no path is provided
target_dir="${1:-.}"

# Check if the directory exists
if [ ! -d "$target_dir" ]; then
    echo "Error: Directory '$target_dir' does not exist."
    exit 1
fi

# Move to the target directory to process files
cd "$target_dir" || exit 1
echo "Processing .mdx files in: $(pwd)"

# Loop through all .mdx files in the specified directory
for file in *.mdx; do
    # Skip if no .mdx files are found
    [ -e "$file" ] || continue
    
    # Skip if the file is already named "page.mdx"
    if [ "$file" = "page.mdx" ]; then
        echo "Skipping $file as it's already named page.mdx"
        continue
    fi
    
    # Extract the filename without extension
    filename=${file%.mdx}
    
    # Create a directory with the same name
    mkdir -p "$filename"
    
    # Move and rename the file
    mv "$file" "$filename/page.mdx"
    
    echo "Moved $file to $filename/page.mdx"
done

echo "Processing complete."
