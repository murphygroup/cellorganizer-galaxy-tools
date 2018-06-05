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

if [ "$2" = "ometiff" ]; then
    echo "Downloaded .$2 image"
    cp -v download ./image.ome.tif
    echo "Validating file"
    xmlvalid ./image.ome.tif | grep -q "No validation errors found."
    if (($? == 0)); then
	echo "File is valid"
	exit 0
    else
	echo "File is not valid"
	rm -f ./download
	exit -1
    fi
elif [ "$2" = "mat" ]; then
    echo "Downloaded .$2 model"
else
    echo "File format: $2 is not supported by this tool"
    exit -1
fi
