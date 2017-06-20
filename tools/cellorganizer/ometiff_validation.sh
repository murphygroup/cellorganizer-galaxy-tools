#!/bin/bash

ln -s $1 ./valid_image.ome.tif

xmlvalid valid_image.ome.tif

if ! xmlvalid valid_image.ome.tif | grep -q "No validation errors found."; then
	rm -f valid_image.ome.tif
    exit -1
else
	exit 0
fi