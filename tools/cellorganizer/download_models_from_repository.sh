#!/bin/bash

dataset=$1

echo "Downloading "$dataset
echo wget --quiet -O model.mat -nc http://www.cellorganizer.org/downloads/models/$dataset
wget --quiet -O model.mat -nc http://www.cellorganizer.org/downloads/models/$dataset 2>/dev/null

find . -type f -empty -exec rm -fv {} \;

if [ ! -f model.mat ]; then
		echo "File does not exist"
		exit 1
fi
