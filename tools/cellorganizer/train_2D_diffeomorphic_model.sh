#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)
CELLORGANIZER=/pylon1/mc4s8dp/icaoberg/galaxy/cellorganizer

WORKING_DIRECTORY=`pwd`

MATLAB=/opt/packages/matlab/R2016a/bin/matlab

DATASET=$1
NUMBER_OF_IMAGES=$2
DOWNSAMPLE_FACTOR=$3

ln -s $CELLORGANIZER $(pwd)/cellorganizer
rsync -va ./cellorganizer/images/HeLa/2D/$DATASET .

echo "
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK
cd ./cellorganizer
setup(true)
cd('$WORKING_DIRECTORY')

options.verbose = true;
options.debug = false;
options.display = true;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Training component: main call to img2slml

% collection, modify these according to your needs
directory = './$DATASET/';
dna = [ directory filesep 'orgdna' filesep 'cell[0-$NUMBER_OF_IMAGES].tif' ];
cellm = [ directory filesep 'orgcell' filesep 'cell[0-$NUMBER_OF_IMAGES].tif' ];
protein = [ directory filesep 'orgprot' filesep 'cell[0-$NUMBER_OF_IMAGES].tif' ];
options.masks = [ directory filesep 'crop' filesep 'cell[0-$NUMBER_OF_IMAGES].tif' ];

options.model.resolution = [ 0.49, 0.49 ];
options.model.filename = 'model.mat';
options.model.id = num2str(now);
options.model.name = 'cellorganizer-on-galaxy';

%set nuclei and cell model name
options.nucleus.name = 'num2str(now)';
options.cell.model = 'num2str(now)';

%set the dimensionality of the model
dimensionality = '2D';

%documentation
options.documentation.description = 'This model has been trained on CellOrganizer on Galaxy+Bridges';

%set model type
options.nucleus.class = 'framework';
options.cell.class = 'framework';
options.nucleus.type = 'diffeomorphic';
options.cell.type = 'diffeomorphic';
options.train.flag = 'framework';

options.downsampling = [$DOWNSAMPLE_FACTOR,$DOWNSAMPLE_FACTOR];

%train the model
success = img2slml( dimensionality, dna, cellm,[], options );

exit;" > script.m

echo "Running the following script in Matlab"
cat script.m

echo $WORKING_DIRECTORY
ln -s $CELLORGANIZER $(pwd)/cellorganizer
$MATLAB -nodesktop -nosplash -r "script;"
