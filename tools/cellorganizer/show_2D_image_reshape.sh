#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)

WORKING_DIRECTORY=`pwd`

INPUT=$1

ln -s $CELLORGANIZER $(pwd)/cellorganizer
validate_ometiff_file.sh $INPUT > /dev/null
valid=$?

if [ $valid == 1 ]; then
    echo "File is not a valid OME.TIFF"
    exit 1
fi

echo "
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK 
WORK_DIR = '$WORKING_DIRECTORY';
cd ./cellorganizer
setup();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

file = '$INPUT';
disp( ['Loading image ' file] );
img = tif2img( file );
img2 = reshape( img, size(img, 1), [] );
img2 = uint8( img2 );
imwrite( img2, [ WORK_DIR filesep 'output.png' ] );
exit;" | $MATLAB
exit 0
