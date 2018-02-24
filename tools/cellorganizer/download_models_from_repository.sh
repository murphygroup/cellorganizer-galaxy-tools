#!/bin/bash

dataset=$1

echo "Downloading "$dataset
echo wget --quiet -O model.mat -nc http://www.cellorganizer.org/model_repository/$dataset
wget --quiet -O model.mat -nc http://www.cellorganizer.org/model_repository/$dataset

find . -type f -empty -exec rm -fv {} \;

find . -type f

if [ ! -f model.mat ]; then
		echo "File does not exist"
fi
