#!/bin/bash

SCRIPT=$1
#2>/dev/null
cat $SCRIPT | matlab -nodesktop -nosplash
rm -fv $SCRIPT

find . -type f -name "cell1.ome.tif" -exec mv -v {} . \;
