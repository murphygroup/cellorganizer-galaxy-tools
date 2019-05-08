#!/bin/bash

FILES=$1

echo $FILES | tr ',' '\n' > files.txt

for FILE in $(cat files.txt)
do
	COUNTER=$((COUNTER+1))
	VALUE=`printf "%05d\n" $COUNTER`
	if [ -f $FILE ]; then
		echo Linking $FILE to image$VALUE.ome.tif
		ln -s $FILE ./image$VALUE.ome.tif 2>/dev/null
	fi
done

rm -f files.txt
