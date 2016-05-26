#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)
WORKING_DIRECTORY=`pwd`
MATLAB=matlab

if [ "$#" -ne 1 ]; then
  SEED=12345
  NUMBER_OF_IMAGES=1
  COMPRESSION='lzw'
else
  SEED=$1
  NUMBER_OF_IMAGES=$2
  COMPRESSION=$3
fi

echo "
% demo2D00
%
% Synthesize one 2D image from all vesicles models found in the models
% folder included in this distribution.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK
addpath( genpath([pwd filesep 'cellorganizer']));

options.targetDirectory = pwd;
options.prefix = 'output';
options.debug = false;
options.verbose = true;
options.display = false;

options.seed=$SEED;
try
    state = rng( options.seed );
catch err
    state = rand( 'seed', options.seed ); %#ok<RAND>
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options.numberOfSynthesizedImages=$NUMBER_OF_IMAGES
options.compression = '$COMPRESSION';
options.targetDirectory = pwd;
options.debug = false;
options.verbose = true;
options.display = false;

tic
answer = slml2img( {'./cellorganizer/models/2D/nucleolus.mat', ...
  './cellorganizer/models/2D/endosome.mat', ...
  './cellorganizer/models/2D/mitochondrion.mat', ...
  './cellorganizer/models/2D/lysosome.mat'}, options );
toc

exit;" > script.m

ln -s $CELLORGANIZER $(pwd)/cellorganizer
$MATLAB -nodesktop -nosplash -r "script;"

cd $WORKING_DIRECTORY
rm -fv ./cellorganizer
