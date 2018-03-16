#!/bin/bash

echo "Downloading "$1
echo wget --quiet -O image.ome.tif -nc $1
wget --quiet -O image.ome.tif -nc $1 2>/dev/null

echo "Checking file"
find . -type f -empty -exec rm -fv {} \;
ls
if [ ! -f image.ome.tif ]; then
    echo "File does not exist"
    exit 1
fi

echo "Validating file"

xmlvalid ./image.ome.tif | grep -q "No validation errors found."
if (($? == 0)); then
    echo "File is valid"
    exit 0
else
    echo "File is not valid"
    rm -f ./image.ome.tif
    exit -1
fi
