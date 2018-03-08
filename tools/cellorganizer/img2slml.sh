#!/bin/bash

FILE=`cat script.m`
echo $FILE | matlab -nodesktop -nosplash

rm -fv script.m

if [ ! -d $1 ]; then
	mkdir $1
fi

if [ -f model.mat ]; then
	cp -v model.mat $1/
fi
