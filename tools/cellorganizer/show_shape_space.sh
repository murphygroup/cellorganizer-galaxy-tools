#!/usr/bin/env bash

MODEL=$1
NUMBER_OF_LABELS=$2
GRID_SIZE=$3
DRAW_TRACES=false

echo "Writing temporary file"
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

check_if_files_exist_on_disk_and_link_them_mat('$MODEL');
diary diary.txt;
file = './model00001.mat'; 
options.nlabels = $NUMBER_OF_LABELS;
options.traces = $DRAW_TRACES;
options.subsize = $GRID_SIZE;

show_shape_space_figure_galaxy_wrapper( file, options );
diary off;
toc,
exit;
EOF

echo "Running Matlab script"
cat script.m
cat script.m | matlab -nodesktop
rm -fv script.m

if [ -f show_shape_space.png ]; then
	exit
fi

if [ ! -f show_shape_space.png ]; then
	exit 1
fi