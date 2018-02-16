#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)

WORKING_DIRECTORY=`pwd`

INPUT=$1
RED=$2
GREEN=$3
BLUE=$4

ln -s $CELLORGANIZER $(pwd)/cellorganizer
validate_ometiff_file.sh $INPUT
valid=$?

if [ $valid -ne 0 ]; then
    exit 1
fi

echo "
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK
cd ./cellorganizer
setup();
cd('$WORKING_DIRECTORY');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

answer = show_RGB_image_galaxy_wrapper( '$INPUT', $RED, $GREEN, $BLUE );
exit;" | $MATLAB
exit 0
