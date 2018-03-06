#!/usr/bin/env bash

INPUT=$1
RED=$2
GREEN=$3
BLUE=$4

cat << EOF >> script.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK
tic;
current_directory = pwd; 
cellorganizer_directory = getenv('CELLORGANIZER'); 
cd( cellorganizer_directory ); 
setup();
cd( current_directory );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

diary diary.txt;
tic;
answer = show_RGB_projection_galaxy_wrapper_ometiff( '$INPUT', $RED, $GREEN, $BLUE );
toc,
diary off;
exit; 
EOF

cat script.m | matlab -nodesktop -nosplash
rm -fv script.m

if [ ! -f output.png ]; then
	exit 2
fi
