#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)

WORKING_DIRECTORY=`pwd`

INPUT=$1
VIEWANGLEX=$2
VIEWANGLEY=$3
ALPHAVAL=$4

cp -v $INPUT $(pwd)/output.tif

echo "
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK
cd ./cellorganizer
setup();
cd('$WORKING_DIRECTORY');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

colors = {'blue', 'green' 'red'};
viewangles = [$VIEWANGLEX,$VIEWANGLEY];

%transparency
alphaval = $ALPHAVAL;

% show shape space by calling the function
f = figure('visible','off');
syn2surfaceplot( pwd, colors, viewangles, alphaval );
saveas( f, 'output.png', 'png' );

exit;" > script.m

ln -s $CELLORGANIZER $(pwd)/cellorganizer
$MATLAB -nodesktop -nosplash -r "script;"
