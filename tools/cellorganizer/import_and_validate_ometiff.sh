#!/bin/bash

wget --quiet -O image.ome.tif -o /dev/null -nc $1

echo "Checking file"
file ./image.ome.tif

echo "Validating file"
xmlvalid ./image.ome.tif

if ! xmlvalid ./image.ome.tif | grep -q "No validation errors found."; then
	echo "File is not valid"
	rm -f ./image.ome.tif
	exit -1
else
	echo "File is valid"
	exit 0
fi
