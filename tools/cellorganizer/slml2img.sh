#!/bin/bash

SCRIPT=$1
pwd
cat $SCRIPT | matlab -nodesktop -nosplash
rm -fv $SCRIPT

if [ ! -d $2 ]; then
        echo "Making folder "$2
        mkdir $2
fi

find . -type f -name "cell1.ome.tif" -exec cp -v {} $2 \;
find . -type f -name "*.png" -exec cp -v {} $2 \;
find . -type f -name "*.xml" -exec cp -v {} $2 \;
find . -type f -name "*.vcml" -exec cp -v {} $2 \;

find . -type f -name "cell1.ome.tif" -exec cp -v {} . \;
find . -type f -name "*.png" -exec cp -v {} . \;
find . -type f -name "*.xml" -exec cp -v {} . \;
find . -type f -name "*.vcml" -exec cp -v {} . \;
