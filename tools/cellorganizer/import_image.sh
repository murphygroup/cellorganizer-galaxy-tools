#!/bin/bash

echo "Downloading "$1
echo wget --quiet -O download -nc $1
wget --quiet -O download -nc $1 2>/dev/null

echo "Checking file"
find . -type f -empty -exec rm -fv {} \;
ls
if [ ! -f download ]; then
    echo "File does not exist"
    exit 1
fi

cp -v download ./image.ome.tif
echo "Validating file"
xmlvalid ./image.ome.tif | grep -q "No validation errors found."
if (($? == 0)); then
    echo "File is a valid OMETIFF"
    exit 0
else
    echo "File is not a valid OMETIFF"
    rm -f ./download
    exit -1
fi
