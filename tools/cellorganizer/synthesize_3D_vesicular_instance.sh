#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)

WORKING_DIRECTORY=`pwd`

INPUT=$1
cp -v $INPUT $(pwd)/model.mat

echo "
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK
cd ./cellorganizer
setup();
cd('$WORKING_DIRECTORY')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% specify model name and load model
files = {'./model.mat'};
options.synthesis = 'all';

options.targetDirectory = pwd;
options.prefix = 'example';
options.compression = 'lzw';
options.sampling.method = 'disc';

if isfield( model, 'proteinModel' )
  options.synthesis = 'all';
else
  options.synthesis = 'framework';
end

slml2img( files, options );

exit;" > script.m

echo $WORKING_DIRECTORY
ln -s $CELLORGANIZER $(pwd)/cellorganizer
$MATLAB -nodesktop -nosplash -r "script;"

zip -rv output.zip example
rm -rfv example
