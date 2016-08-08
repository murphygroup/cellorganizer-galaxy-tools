#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)

WORKING_DIRECTORY=`pwd`

INPUT=$1
cp -v $INPUT $(pwd)/model.mat

NUMBER_OF_LABELS=$2
GRID_SIZE=$3
DRAW_TRACES=$4

echo "
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK
cd ./cellorganizer
setup();
cd('$WORKING_DIRECTORY')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

file = './model.mat';
options.nlabels = $NUMBER_OF_LABELS;
options.traces = $DRAW_TRACES;
options.subsize = $GRID_SIZE;

show_shape_space_figure_galaxy_wrapper( file, options );

exit;" > script.m

cat script.m

ln -s $CELLORGANIZER $(pwd)/cellorganizer
$MATLAB -nodesktop -nosplash -r "script;"
