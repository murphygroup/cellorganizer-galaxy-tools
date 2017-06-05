#!/bin/bash

ln -s $1 ./valid_image.ome.tif
ls -lt
xmlvalid valid_image.ome.tif

if ! xmlvalid valid_image.ome.tif | grep -q "No validation errors found."; then
	rm -f valid_image.ome.tif
	ls -lt
    exit -1
else
	exit 0
fi