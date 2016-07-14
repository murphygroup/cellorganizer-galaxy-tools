#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)
CELLORGANIZER=/pylon1/mc4s8dp/icaoberg/galaxy/cellorganizer

WORKING_DIRECTORY=`pwd`

MATLAB=/opt/packages/matlab/R2016a/bin/matlab

MODEL1=$1
MODEL2=$2

echo "
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK
cd ./cellorganizer
setup(true);
cd('$WORKING_DIRECTORY')

models = {$MODEL1; $MODEL2};
param = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FEEL FREE TO MODIFY THE VARIABLES IN THIS BLOCK
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

answer = model2report(model,param)

exit;" > script.m

echo "Running the following script in Matlab"
cat script.m

echo $WORKING_DIRECTORY
ln -s $CELLORGANIZER $(pwd)/cellorganizer
$MATLAB -nodesktop -nosplash -r "script;"

echo "Compressing results"
zip -rv report.zip report*.pdf
rm -rfv report*.pdf
