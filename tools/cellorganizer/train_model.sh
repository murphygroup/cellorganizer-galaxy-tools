#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)

WORKING_DIRECTORY=`pwd`
DATASET=$1
MASKSET=$2
TRAINFLAG=$3
MODELNAME=$4
MODELID=$5
DOWNSAMPLE=$6
NUCLEUSTYPE=$7
NUCLEUSNAME=$8
NUCLEUSCLASS=$9
NUCLEUSID=$10
CELLTYPE=$11
CELLNAME=$12
CELLCLASS=$13
CELLID=$14
PROTEINTYPE=$15
PROTEINNAME=$16
PROTEINCLASS=$17
PROTEINID=$18
PROTEINCYTONUCLEARFLAG=$19
DOCUMENTATION=$20
VERBOSE=$21
DEBUG=$22

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

masks = $MASKSET

%%% parese image data
f1 = fopen(dataset);
imagepaths = textscan(f1,'%s\n');
imagepaths = imagepaths{1};
fclose(f1);

%%% get dna imagepaths
dnainds = ~cellfun(@isempty,regexp(imagepaths,'ch0'));
dnapaths = imagepaths(dnainds);

%%% get cell imagepaths
cellinds = ~cellfun(@isempty,regexp(imagepaths,'ch1'));
cellpaths = imagepaths(cellinds);

%%% get prot image paths
protinds = cellinds+dnainds<1;
protpaths = imagepaths(protinds);

%%% get cell mask paths
try
    f2 = fopen(masks);
    maskpaths = textscan(f2,'%s\n');
    maskpaths = maskpaths{1};
    fclose(f2);
    options.masks = maskpaths;
catch
    disp('no mask images found')
end

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
