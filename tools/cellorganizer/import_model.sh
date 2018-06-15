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

#verification?
echo "Downloaded generative model"
