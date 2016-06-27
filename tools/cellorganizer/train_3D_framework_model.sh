#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)

WORKING_DIRECTORY=`pwd`

DATASET=$1
NUMBER_OF_IMAGES=$2
DOWNSAMPLE_FACTOR=$3
IS_DIFFEOMORPHIC=$4

echo "
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK
cd ./cellorganizer
setup()
cd('$WORKING_DIRECTORY')

options.verbose = true;
options.debug = false;
options.display = true;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Training component: main call to img2slml

% collection, modify these according to your needs
directory = './cellorganizer/images/HeLa/3D/processed';

number_of_images = $NUMBER_OF_IMAGES;
files = dir([ directory filesep '$DATASET*cell*ch0*.tif' ]);

if number_of_images > length(files)
  warning('You are trying to select more images than those available in this dataset. Selecting the maximum available images.')
  number_of_images = length(files)
end

files = files(1:number_of_images);
dna = {};
for i=1:1:length(files)
    dna{length(dna)+1} = [ directory filesep files(i).name];
end

files = dir([ directory filesep '$DATASET*cell*ch1*.tif' ]);
files = files(1:number_of_images);
cellm = {};
for i=1:1:length(files)
    cellm{length(cellm)+1} = [ directory filesep files(i).name];
end

files = dir([ directory filesep '$DATASET*cell*ch2*.tif' ]);
files = files(1:number_of_images);
protein = {};
for i=1:1:length(files)
    protein{length(protein)+1} = [directory filesep files(i).name];
end

files = dir([ directory filesep '$DATASET*cell*mask*.tif' ]);
files = files(1:number_of_images);
masks = {};
for i=1:1:length(files)
    masks{length(masks)+1} = [directory filesep files(i).name];
end
options.masks = masks;

for i=1:1:length(dna)
  disp(dna{i})
end

for i=1:1:length(cellm)
  disp(cellm{i})
end

for i=1:1:length(protein)
  disp(protein{i})
end

for i=1:1:length(masks)
  disp(masks{i})
end

options.model.resolution = [0.49, 0.49 0.02];
options.model.filename = 'model.mat';
options.model.id = num2str(now);
options.model.name = 'cellorganizer-on-galaxy';

%set nuclei and cell model name
options.nucleus.name = num2str(now);
options.cell.model = num2str(now);

%set the dimensionality of the model
dimensionality = '3D';

%documentation
options.documentation.description = 'This model has been trained on CellOrganizer on Galaxy+Bridges';

train_diffeomorphic_model=$IS_DIFFEOMORPHIC

if train_diffeomorphic_model
%set model type
  options.nucleus.class = 'framework';
  options.cell.class = 'framework';
  options.nucleus.type = 'diffeomorphic';
  options.cell.type = 'diffeomorphic';
  options.train.flag = 'framework';
else
  options.nucleus.class = 'nuclear_membrane';
  options.cell.class = 'cell_membrane';
  options.nucleus.type = 'cylindrical_surface';
  options.cell.type = 'ratio';
  options.train.flag = 'framework';
end

options.downsampling = [$DOWNSAMPLE_FACTOR,$DOWNSAMPLE_FACTOR,1];

%train the model
success = img2slml( dimensionality, dna, cellm,[], options );

exit;" > script.m

ln -s $CELLORGANIZER $(pwd)/cellorganizer
$MATLAB -nodesktop -nosplash -r "script;"
