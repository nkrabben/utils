#!/bin/bash
# Export the tags of all TIFF files in a folder.
# This script assumes that all files have been produced by the same process
# and will have similar tags. It produces a CSV file where each row contains
# the value of all tags prefixed by the filename.

# Find all tif files in current and subdirectories

FILES="$(find . -type f -name '*.tif*')"

# Run tiffdump on each file, grep the value of each tag, comma separate values
# and prefix file name. Write results to tags.csv.
for f in $FILES;
do
  tiffdump $f | grep -o '<.*>' | paste -sd "," - | sed "s#^#$f,#";
done > tags.csv
