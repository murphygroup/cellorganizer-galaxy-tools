#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)
CELLORGANIZER=/pylon1/mc4s8dp/icaoberg/galaxy/cellorganizer

WORKING_DIRECTORY=`pwd`

MATLAB=/opt/packages/matlab/R2016a/bin/matlab

INPUT=$1
DOWNSAMPLING=$2

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

files = dir( [ pwd filesep '*.tif'] );
for index=1:1:length(files)
  file = files(index).name;
  disp( ['Loading image ' file]);
  img = tif2img( file );
  [path,filename,ext]=fileparts(file);
  file = [filename '.obj'];
  shiftvector = [];
  [shiftvector, ~] = im2blender( img, [pwd filesep file], [$DOWNSAMPLING $DOWNSAMPLING $DOWNSAMPLING], ...
                    [], shiftvector);
end

exit;" > script.m

ln -s $CELLORGANIZER $(pwd)/cellorganizer
$MATLAB -nodesktop -nosplash -r "script;"

zip output.zip *.tif
zip output.zip *.obj
zip output.zip *.mtl
