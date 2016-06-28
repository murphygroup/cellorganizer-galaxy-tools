#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)

WORKING_DIRECTORY=`pwd`

INPUT=$1
RED=$2
GREEN=$3
BLUE=$4

ln -s $INPUT $(pwd)/output.zip
unzip ./output.zip
rm -fv output.zip
find . -type f -name "*.tif" -exec mv -v {} . \;

echo "Generating Matlab script"
echo "
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK
cd ./cellorganizer
setup();
cd('$WORKING_DIRECTORY');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

directory = pwd;
answer = show_RGB_image_galaxy_wrapper( directory, $RED, $GREEN, $BLUE );
exit;" > script.m

echo "Linking CellOrganizer"
ln -s $CELLORGANIZER $(pwd)/cellorganizer

echo "Running script"
$MATLAB -nodesktop -nosplash -r "script;"
