#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)
CELLORGANIZER=/pylon1/mc4s8dp/icaoberg/galaxy/cellorganizer

WORKING_DIRECTORY=`pwd`

MATLAB=/opt/packages/matlab/R2016a/bin/matlab

SEED=$1
NUMBER_OF_SYNTHESIZED_IMAGES=$2
NUMBER_OF_GAUSSIAN_OBJECTS=$3

echo "
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SEED EXAMPLE
seed = $SEED
try
    state = rng(seed);
catch
    state = RandStream.create('mt19937ar','seed',seed);
    RandStream.setDefaultStream(state);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

options.image_size = 512;

a = randi([100 200]);
b = randi([100 200]);
c = randi([100 200]);
param.instance.nucleus = generate_ellipsoid(a,b,c,options);

a = randi([250 500]);
b = randi([250 500]);
c = randi([250 500]);
param.instance.cell = generate_ellipsoid(a,b,c,options);

%step0.2: set the resolution of the latter images
param.instance.resolution = [0.049, 0.049, 0.2000];

%step0.3: use a valid CellOrganizer model that contains a protein model. in
%this model we are going to use the 3D HeLa nucleoli model distrubuted in
%this version of CellOrganizer
model_file_path = './cellorganizer/models/3D/tfr.mat';

%these are optional parameters that you are welcome to modify as needed
%location where CellOrganizer will save the images to
param.targetDirectory = pwd;

%output folder name
param.prefix = 'examples';

%number of images to synthesize
param.numberOfSynthesizedImages = $NUMBER_OF_SYNTHESIZED_IMAGES;

%save images as TIF files
param.output.tifimages = true;

%compression for TIF output
param.compression = 'lzw';

%do not apply point-spread-function
param.microscope = 'none';

%render Gaussian objects as discs
param.sampling.method = 'disc';

%overlap frequency model and generate a single object
param.numberOfGaussianObjects = $NUMBER_OF_GAUSSIAN_OBJECTS;

%generate framework
param.synthesis = 'all';

%generate SBML output
options.output.blenderfile = true;
options.output.blender.downsample = [1 1 1];

%helper options
param.verbose = true;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%main call to CellOrganizer
slml2img( {model_file_path},  param );

exit;" > script.m

echo "Running the following script in Matlab"
cat script.m

echo $WORKING_DIRECTORY
ln -s $CELLORGANIZER $(pwd)/cellorganizer
$MATLAB -nodesktop -nosplash -r "script;"

echo "List files"
ls *

echo "Compressing results"
if [ -d examples ]; then
  zip -rv examples.zip examples
  rm -rfv examples
fi
