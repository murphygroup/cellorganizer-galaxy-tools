#!/usr/bin/env bash

INPUT=$1

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
img = ometiff2reshape( '$INPUT' );
imwrite( img, './output.png' );
toc,
diary off;
exit; 
EOF

cat script.m | matlab -nodesktop -nosplash
rm -fv script.m

if [ ! -f output.png ]; then
	exit 2
fi
