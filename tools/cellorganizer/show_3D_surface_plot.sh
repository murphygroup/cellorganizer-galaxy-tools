#!/bin/bash

IMAGE=$1
VIEWANGLEX=$2
VIEWANGLEY=$3
ALPHAVAL=$4

echo "Linking image to current working directory"
ln -s $IMAGE $(pwd)/img.ome.tif

echo "Writing temporary file"
cat << EOF >> script.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK
tic;
current_directory = pwd; 
cellorganizer_directory = getenv('CELLORGANIZER'); 
cd( cellorganizer_directory ); 
setup(); 
cd( current_directory );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

colors = {'blue', 'green' 'red'};
viewangles = [$VIEWANGLEX,$VIEWANGLEY];

%transparency
alphaval = $ALPHAVAL;

% show shape space by calling the function
f = figure('visible','off');
syn2surfaceplot_ometiff( './img.ome.tif', colors, viewangles, alphaval );
saveas( f, 'output.png', 'png' );
toc,
exit;
EOF

echo "Running Matlab script"
cat script.m
cat script.m | matlab -nodesktop -nosplash 2>/dev/null 
rm -fv script.m

if [ -f output.png ]; then
	exit
fi

if [ ! -f output.png ]; then
	exit 1
fi
