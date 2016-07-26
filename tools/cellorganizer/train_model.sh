#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)

WORKING_DIRECTORY=`pwd`
DATASET=$1
DNACHANNEL=$2
CELLCHANNEL=$3
PROTEINCHANNEL=$4
MASKSET=$5
TRAINFLAG=$6
MODELNAME=$7
MODELID=$8
DOWNSAMPLE=$9
NUCLEUSTYPE=$10
NUCLEUSNAME=$11
NUCLEUSCLASS=$12
NUCLEUSID=$13
CELLTYPE=$14
CELLNAME=$15
CELLCLASS=$16
CELLID=$17
PROTEINTYPE=$18
PROTEINNAME=$19
PROTEINCLASS=$20
PROTEINID=$21
PROTEINCYTONUCLEARFLAG=$22
DOCUMENTATION=$23
VERBOSE=$24
DEBUG=$25

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

%%% pares image data
f1 = fopen(dataset);
imagepaths = textscan(f1,'%s\n');
imagepaths = imagepaths{1};
fclose(f1);

%%% get dna imagepaths
dna_channel_numbers = OME_getChannelNumbers(imagepaths, $DNACHANNEL)
dna_paths = [imagepaths,dna_channel_numbers];
%dnainds = ~cellfun(@isempty,regexp(imagepaths,'ch0'));
%dnapaths = imagepaths(dnainds);

%%% get cell imagepaths
cell_channel_numbers = OME_getChannelNumbers(imagepaths, $CELLCHANNEL)
cell_paths = [imagepaths,cell_channel_numbers];
%cellinds = ~cellfun(@isempty,regexp(imagepaths,'ch1'));
%cellpaths = imagepaths(cellinds);

%%% get prot image paths
protein_channel_numbers = OME_getChannelNumbers(imagepaths, $PROTEINCHANNEL)
dna_paths = [imagepaths,protein_channel_numbers];
%protinds = cellinds+dnainds<1;
%protpaths = imagepaths(protinds);

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

%%% get image resolution and dimensionality
options.model.resolution = OME_getResolution(imagepaths{1});
if ~isempty(options.model.resolution)


    reader = bfGetReader(image_path);
    omeMeta = reader.getMetadataStore();
    if omeMeta.getPixelsSizeZ(0).getValue()>2
        dimensionality = '3D';
    else
        dimensionality = '2D';

    %reader = bfGetReader(imagepaths{1});
    %omeMeta = reader.getMetadataStore();

    %xrange = omeMeta.getPixelsSizeX(0).getValue();
    %xpixelsize = omeMeta.getPixelsPhysicalSizeX(0).value();

    %yrange = omeMeta.getPixelsSizeY(0).getValue();
    %ypixelsize = omeMeta.getPixelsPhysicalSizeY(0).value();

    %try
    %    zrange = omeMeta.getPixelsSizeZ(0).getValue();
    %    zpixelsize = omeMeta.getPixelsPhysicalSizeZ(0).value();
    %    dimensionality = '3D';
    %    options.model.resolution = [xrange/xpixelsize yrange/ypixelsize zrange/zpixelsize];
    %    options.model.original_resolution = [xrange/xpixelsize yrange/ypixelsize zrange/zpixelsize];
    %catch
    %    dimensionality = '2D';
    %    options.model.resolution = [xrange/xpixelsize yrange/ypixelsize];
    %    options.model.original_resolution = [xrange/xpixelsize yrange/ypixelsize];
    %end

    answer = img2slml(dimensionality, dnapath, cellpath, proteinpath, options);
else
    disp('No resolution specified, exiting.')
end
exit;" > script.m

ln -s $CELLORGANIZER $(pwd)/cellorganizer
$MATLAB -nodesktop -nosplash -r "script;"
