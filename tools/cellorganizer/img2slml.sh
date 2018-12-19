#!/bin/bash

bash ./check_if_files_exist_on_disk_and_link_them.sh "$1" 2>/dev/null 

cat script.m | matlab -nodesktop -nosplash

if [ ! -d $2 ]; then
	echo "Making folder "$2
	mkdir $2
fi

if [ -f model.mat ]; then
	echo "Copying model.mat"
	cp -v model.mat $2/
fi

if [ -d ./param ]; then
	echo "Creating parameterization_and_temp_results.zip"
	zip -r parameterization_and_temp_results.zip param temp
	cp -v parameterization_and_temp_results.zip $2
	rm -rf param
fi
