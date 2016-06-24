#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)

WORKING_DIRECTORY=`pwd`

INPUT=$1
RED=$2
GREEN=$3
BLUE=$4

echo "Setting working directory to "$WORKING_DIRECTORY
echo "Linking output image"
ln -s $INPUT $(pwd)/output.tif

echo "Generating Matlab script"
echo "
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK
cd ./cellorganizer
setup();
cd('$WORKING_DIRECTORY');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

answer = show_RGB_image_galaxy_wrapper( file, red, green, blue );
if answer
  exit;
else
  exit(-1)
end" > script.m

echo "Linking CellOrganizer"
ln -s $CELLORGANIZER $(pwd)/cellorganizer

echo "Running script"
$MATLAB -nodesktop -nosplash -r "script;"
