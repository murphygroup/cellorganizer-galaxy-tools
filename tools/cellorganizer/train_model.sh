#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)

WORKING_DIRECTORY=`pwd`
DATASET=$1
TRAINFLAG=$2
MODELNAME=$3
MODELID=$4
DOWNSAMPLE=$5
NUCLEUSTYPE=$6
NUCLEUSNAME=$7
NUCLEUSCLASS=$8
NUCLEUSID=$9
CELLTYPE=$10
CELLNAME=$11
CELLCLASS=$12
CELLID=$13
PROTEINTYPE=$14
PROTEINNAME=$15
PROTEINCLASS=$16
PROTEINID=$17
PROTEINCYTONUCLEARFLAG=$18
DOCUMENTATION=$19
VERBOSE=$20
DEBUG=$21

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

%%%% parse varargin
dataset = $DATASET; %path to images
%masks = varargin{2}; %bool
options.train.flag = $TRAINFLAG; %nuclear, frame, all %% add a default in the shell script so train.flag is always var 3
options.model.name = $MODELNAME; %same as above, optional
options.model.filename = [options.model.name '.mat'];
options.model.id = $MODELID; %random string%

if strcmpi(options.model.id, '')
	options.model.id = num2str(now)
end

options.downsampling = [$DOWNSAMPLE $DOWNSAMPLE 1];

options.nucleus.type = $NUCLEUSTYPE; % medial axis, cylindrical surface or diffeo
options.nucleus.name = $NUCLEUSNAME; %defualt to empty
options.nucleus.class = $NUCLEUSCLASS; % nuc or framework
options.nucleus.id = $NUCLEUSID;

if strcmpi(options.nucleus.id, '')
	options.nucleus.id = num2str(now)
end

options.cell.type = $CELLTYPE;
options.cell.name = $CELLNAME;
options.cell.class = $CELLCLASS;
options.cell.id = $CELLID;

if strcmpi(options.cell.id, '')
	options.cell.id = num2str(now)
end


options.protein.type = $PROTEINTYPE;
options.protein.name = $PROTEINNAME;
options.protein.class = $PROTEINCLASS;
options.protein.id = $PROTEINID;

if strcmpi(options.protein.id, '')
	options.protein.id = num2str(now)
end


options.protein.cytonuclearflag = $PROTEINCYTONUCLEARFLAG;

options.documentation.name = $DOCUMENTATION;

options.verbose = $VERBOSE;
options.debug = $DEBUG;

%%% parese image data
f1 = fopen(dataset);
imagepaths = textscan(f1,'%s\n');
fclose(f1);

reader = bfGetReader(imagepaths{1});
omeMeta = reader.getMetadataStore();

xrange = omeMeta.getPixelsSizeX(0).getValue();
xpixelsize = omeMeta.getPixelsPhysicalSizeX(0).value();

yrange = omeMeta.getPixelsSizeY(0).getValue();
ypixelsize = omeMeta.getPixelsPhysicalSizeY(0).value();

try
    zrange = omeMeta.getPixelsSizeZ(0).getValue();
    zpixelsize = omeMeta.getPixelsPhysicalSizeZ(0).value();
    dimensionality = '3D';
    options.model.resolution = [xrange/xpixelsize yrange/ypixelsize zrange/zpixelsize];
    options.model.original_resolution = [xrange/xpixelsize yrange/ypixelsize zrange/zpixelsize];
catch
    dimensionality = '2D';
    options.model.resolution = [xrange/xpixelsize yrange/ypixelsize];
    options.model.original_resolution = [xrange/xpixelsize yrange/ypixelsize];
end

answer = img2slml(dimensionality, dnapath, cellpath, proteinpath, options);

exit;" > script.m

ln -s $CELLORGANIZER $(pwd)/cellorganizer
$MATLAB -nodesktop -nosplash -r "script;"
