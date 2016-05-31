#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)
CELLORGANIZER=/pylon1/mc4s8dp/icaoberg/galaxy/cellorganizer

WORKING_DIRECTORY=`pwd`

MATLAB=/opt/packages/matlab/R2016a/bin/matlab

NUMBER_OF_IMAGES=$1

echo "
% mmbios04

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK
addpath( genpath([pwd filesep 'cellorganizer']));

options.verbose = true;
options.debug = false;
options.display = true;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% training component: main call to img2slml

% collection, modify these according to your needs
directory = './cellorganizer/images/HeLa/2D/LAM/';
dna = [ directory filesep 'orgdna' filesep 'cell[0-$NUMBER_OF_IMAGES].tif' ];
cellm = [ directory filesep 'orgcell' filesep 'cell[0-$NUMBER_OF_IMAGES].tif' ];
protein = [ directory filesep 'orgprot' filesep 'cell[0-$NUMBER_OF_IMAGES].tif' ];
options.masks = [ directory filesep 'crop' filesep 'cell[0-$NUMBER_OF_IMAGES].tif' ];

options.model.resolution = [ 0.49, 0.49 ];
options.model.filename = 'model.mat';
options.model.id = 'lamp2';
options.model.name = 'lamp2';

%set nuclei and cell model name
options.nucleus.name = 'LAMP2';
options.cell.model = 'LAMP2';

%set the dimensionality of the model
dimensionality = '2D';

%documentation
options.documentation.description = 'This model has been trained using demo2D04 from CellOrganizer';

%set model type
options.nucleus.class = 'framework';
options.cell.class = 'framework';
options.nucleus.type = 'diffeomorphic';
options.cell.type = 'diffeomorphic';
options.train.flag = 'framework';

options.downsampling = [5,5];

%train the model
success = img2slml( dimensionality, dna, cellm,[], options );

exit;" > script.m

echo "Running the following script in Matlab"
cat script.m

echo $WORKING_DIRECTORY
ln -s $CELLORGANIZER $(pwd)/cellorganizer
$MATLAB -nodesktop -nosplash -r "script;"
