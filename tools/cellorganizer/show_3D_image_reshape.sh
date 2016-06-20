#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)
CELLORGANIZER=/pylon1/mc4s8dp/icaoberg/galaxy/cellorganizer

WORKING_DIRECTORY=`pwd`

MATLAB=/opt/packages/matlab/R2016a/bin/matlab

INPUT=$1
NUMBER_OF_IMAGES=1
COMPRESSION=$2

ln -s $INPUT $(pwd)/output.zip
unzip ./output.zip
rm -fv output.zip
find . -type f -name "*.tif" -exec mv -v {} . \;

echo "
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK
cd ./cellorganizer
setup();
cd('$WORKING_DIRECTORY');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

imgs = {};
files = dir( [ pwd filesep '*.tif'] );
for index=1:1:length(files)
  file = files(index).name;
  disp( ['Loading image ' file]);
  img = tif2img( file );
  temp = reshape( img, size(img, 1 ), [] );
  temp = uint8(temp);
  size( temp )
  imgs{index} = temp;
end

if ~isempty(imgs)
    img = imgs{1};
end

for index=2:1:length(imgs)
    img = [ img; imgs{index} ];
end

imwrite( img, 'output.png' );

exit;" > script.m

ln -s $CELLORGANIZER $(pwd)/cellorganizer
$MATLAB -nodesktop -nosplash -r "script;"
