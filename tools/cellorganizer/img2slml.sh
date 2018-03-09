#!/bin/bash

bash ./check_if_files_exist_on_disk_and_link_them.sh "$1"

cat script.m | matlab -nodesktop -nosplash

if [ ! -d $2 ]; then
	mkdir $2
fi

if [ -f model.mat ]; then
	cp -v model.mat $1/
fi