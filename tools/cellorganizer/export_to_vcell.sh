#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)

WORKING_DIRECTORY=`pwd`

INPUT=$1

ln -s $INPUT $(pwd)/output.tif

echo "
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK
tic;
current_directory = pwd;
cellorganizer_directory = getenv('CELLORGANIZER');
cd( cellorganizer_directory );
setup();
cd( current_directory );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

img = tif2img( 'output.tif' );

for i=1:1:size(img,3)
   temp = img(:,:,i);
   temp( find(temp~=0) ) = i;
   img(:,:,i) = temp;
end

img2tif(img,'output.tif')

exit;" > script.m

cat script.m | matlab -nodesktop -nosplash
