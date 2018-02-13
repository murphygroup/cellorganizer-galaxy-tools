#!/bin/bash

dataset=$1

echo "Downloading "$dataset
wget --quiet -O model.mat -nc http://www.cellorganizer.org/model_repository/$dataset

find . -type f -empty -exec rm -fv {} \;

if [ ! -f model.mat ]; then
		echo "File does not exist"
		exit -1
fi
