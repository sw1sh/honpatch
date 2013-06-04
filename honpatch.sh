#!/bin/bash

# Fetch patch files to ./honpatch/ directory
./honpatch.py -t . -s . --noapply --no-cleanup --no-perm-copy --resume

# Find s2z files
s2z=`find honpatch -name '*.s2z' -exec echo '{}' \; | cut -d'/' -f 2-`

# Unpack zips and delete them
find honpatch -name '*.zip' -execdir 7z x -tzip -y '{}' \; -exec rm '{}' \;

# Copy everything  (*.s2z won't be copied)
cp -r honpatch/* .

# Update s2z files
for f in $s2z ;
do
  7z u -tzip -r $f honpatch/$f/*
done
