#!/bin/bash

echo "Linking file "$1
cp -v $1 ./image.ome.tif

echo "Checking file"
file ./image.ome.tif

echo "Validating file"
xmlvalid ./image.ome.tif >> output.txt
cat output.txt

if ! xmlvalid ./image.ome.tif | grep -q "No validation errors found."; then
	echo "File is not valid"
	rm -f ./image.ome.tif
	exit 1
else
	echo "File is valid"
	exit 0
fi
