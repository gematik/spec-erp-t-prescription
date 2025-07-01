#!/bin/bash

INPUT_DIR="temp/pages/_includes"
OUTPUT_DIR="output"
PYTHON_SCRIPT="build-sm-table.py"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

echo $INPUT_DIR

shopt -s nullglob  # Makes the loop skip if there are no matches

files=($INPUT_DIR/StructureMap-*script-plain.xhtml)

if [ ${#files[@]} -eq 0 ]; then
    echo "No files found matching pattern."
    exit 0
fi

for file in "${files[@]}"; do
    filename=$(basename "$file")
    outputfile="$OUTPUT_DIR/${filename%.script-plain.xhtml}.md"
    echo "Processing $file -> $outputfile"
    python3 "$PYTHON_SCRIPT" "$file" > "$outputfile"
done