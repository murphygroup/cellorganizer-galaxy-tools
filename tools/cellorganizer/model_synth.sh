#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)

WORKING_DIRECTORY=`pwd`
MODEL1=$1
MODEL2=$2
MODEL3=$3
MODEL4=$4
MODEL5=$5
MODEL6=$6
SYNTHESISFLAG=$7
NUMIMGS=$8
RESOLUTION=$9
PREFIX=$10
COMPRESSION=$11
MICROSCOPE=$12
SAMPLINGMETHOD=$13
VERBOSE=$14
DEBUG=$15
RANDOMWALK=$16
WALKSTEPS=$17
WALKTYPE=$18
TIF=$19
INDEXED=$20
BLENDER=$21
SBML=$22

echo "
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK
pwd
cd ./cellorganizer
pwd
ls
setup();
cd('$WORKING_DIRECTORY')

options.targetDirectory = pwd;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

models = {$MODEL1,$MODEL2,$MODEL3,$MODEL4,$MODEL5,$MODEL6};
options.synthesis = $SYNTHESISFLAG;
options.numberOfSynthesizedImages = $NUMIMGS;
options.resolution.cell = $RESOLUTION;
options.resolution.objects = $RESOLUTION;
options.prefix = $PREFIX;
options.image.compression = $COMPRESSION;
options.microscope = $MICROSCOPE;
options.sampling.method = $SAMPLINGMETHOD;
options.verbose = $VERBOSE;
options.debug = $DEBUG;
options.randomwalk = $RANDOMWALK;
options.walksteps = $WALKSTEPS;
options.walktype = $WALKTYPE;
output.tifimages = $TIF;
output.indexedimage = $INDEXED;   
output.blenderfile = $BLENDER;
output.SBML = $SBML;

answer = slml2img( models, options );

exit;" > script.m

ln -s $CELLORGANIZER $(pwd)/cellorganizer
$MATLAB -nodesktop -nosplash -r "script;"
