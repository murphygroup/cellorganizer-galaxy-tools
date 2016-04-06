#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)
WORKING_DIRECTORY=`pwd`
CELLORGANIZER=/Users/icaoberg/Documents/MATLAB/cellorganizer

SEED=$1
NUMBER_OF_IMAGES=$2

ln -s $CELLORGANIZER $(pwd)/cellorganizer
cd cellorganizer
/Applications/MATLAB_R2015a.app/bin/matlab -nodesktop -nosplash -r "setup(true);param.seed="$SEED";param.numberOfSynthesizedImages="$NUMBER_OF_IMAGES";demo2D00(param); pwd, copyfile( './images/demo2D00_1.tif', '"$WORKING_DIRECTORY"' ); exit;"
cd $WORKING_DIRECTORY
rm -fv cellorganizer
