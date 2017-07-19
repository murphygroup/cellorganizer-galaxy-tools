#!/bin/bash

IFS=',' read -r -a array <<< "$1"
for index in "${!array[@]}"
do
	echo "Linking file_$index"
	cp "${array[index]}" ./image_"$index".ome.tif

	echo "Checking file_$index"
	file ./image_"$index".ome.tif

	echo "Validating file_$index"
	xmlvalid ./image_"$index".ome.tif
	
	if ! xmlvalid image_"$index".ome.tif | grep -q "No validation errors found."; then
		echo "File_$index is not valid"
		rm -f image_"$index".ome.tif
	    exit -1
	else
		echo "File_$index is valid"
	fi
done

zip image.zip image_*
exit 0