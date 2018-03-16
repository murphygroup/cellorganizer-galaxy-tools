#!/bin/bash

bash ./check_if_files_exist_on_disk_and_link_them.sh "$1" 2>/dev/null 

cat script.m | matlab -nodesktop -nosplash
#matlab -nodesktop -nosplash -r "script;" 2>/dev/null 

if [ ! -d $2 ]; then
	mkdir $2
fi

if [ -f model.mat ]; then
	cp -v model.mat $2/
fi
