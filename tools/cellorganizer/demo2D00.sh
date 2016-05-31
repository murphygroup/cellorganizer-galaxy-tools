#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)
CELLORGANIZER=/pylon1/mc4s8dp/icaoberg/galaxy/cellorganizer

WORKING_DIRECTORY=`pwd` 

MATLAB=/opt/packages/matlab/R2016a/bin/matlab

SEED=$1
NUMBER_OF_IMAGES=$2
COMPRESSION=$3

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
options.numberOfSynthesizedImages=$NUMBER_OF_IMAGES;
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

img = tif2img( 'output1.tif' );
img2 = reshape( img, size(img, 1 ), [] );
img2 = uint8(img2);
imwrite( img2, 'output2.png' );

exit;" > script.m

echo "Running the following script in Matlab"
cat script.m

echo $WORKING_DIRECTORY
ln -s $CELLORGANIZER $(pwd)/cellorganizer
$MATLAB -nodesktop -nosplash -r "script;"

echo "List all files in the current tree and subtrees"
find . -type f
