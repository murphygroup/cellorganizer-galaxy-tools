#!/bin/bash

SCRIPT=$1
cat $SCRIPT | matlab -nodesktop -nosplash
rm -fv $SCRIPT

find . -type f -name "cell1.ome.tif" -exec mv -v {} . \;
find . -type f -name "cell.xml" -exec cp -v {} . \;

if [ ! -f cell1.ome.tif ]; then
	exit 1
fi
