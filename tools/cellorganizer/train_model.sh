#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)

WORKING_DIRECTORY=`pwd`
DATASET=$1
DNACHANNEL=$2
CELLCHANNEL=$3
PROTEINCHANNEL=$4
TRAINFLAG=$5
MODELNAME=$6
MODELID=$7
DOWNSAMPLEX=$8
DOWNSAMPLEY=$9
DOWNSAMPLEZ=${10}
NUCLEUSTYPE=${11}
NUCLEUSNAME=${12}
NUCLEUSCLASS=${13}
NUCLEUSID=${14}
CELLTYPE=${15}
CELLNAME=${16}
CELLCLASS=${17}
CELLID=${18}
PROTEINTYPE=${19}
PROTEINNAME=${20}
PROTEINCLASS=${21}
PROTEINID=${22}
PROTEINCYTONUCLEARFLAG=${23}
DOCUMENTATION=${24}
VERBOSE=${25}
DEBUG=${26}

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
dataset = '$DATASET'; %path to images
options.train.flag = '$TRAINFLAG'; %nuclear, frame, all %% add a default in the shell script so train.flag is always var 3
options.model.name = '$MODELNAME'; %same as above, optional
options.model.filename = [options.model.name '.mat'];
options.model.id = '$MODELID'; %random string%

if strcmpi(options.model.id, '')
    options.model.id = num2str(now)
end

options.downsampling = [$DOWNSAMPLEX $DOWNSAMPLEY $DOWNSAMPLEZ];

options.nucleus.type = '$NUCLEUSTYPE'; % medial axis, cylindrical surface or diffeo
options.nucleus.name = '$NUCLEUSNAME'; %defualt to empty
options.nucleus.class = '$NUCLEUSCLASS'; % nuc or framework
options.nucleus.id = '$NUCLEUSID';

if strcmpi(options.nucleus.id, '')
    options.nucleus.id = num2str(now)
end

options.cell.type = '$CELLTYPE';
options.cell.name = '$CELLNAME';
options.cell.class = '$CELLCLASS';
options.cell.id = '$CELLID';

if strcmpi(options.cell.id, '')
    options.cell.id = num2str(now)
end


options.protein.type = '$PROTEINTYPE';
options.protein.name = '$PROTEINNAME';
options.protein.class = '$PROTEINCLASS';
options.protein.id = '$PROTEINID';

if strcmpi(options.protein.id, '')
    options.protein.id = num2str(now)
end


options.protein.cytonuclearflag = '$PROTEINCYTONUCLEARFLAG';

options.documentation.name = '$DOCUMENTATION';

options.verbose = $VERBOSE;
options.debug = $DEBUG;


%%% pares image data
f1 = fopen(dataset);
imagepaths = textscan(f1,'%s\n');
imagepaths = imagepaths{1};
fclose(f1);

%%% get dna imagepaths
if $DNACHANNEL ~= 0
    dna_channel_numbers = OME_getChannelNumbers(imagepaths, $DNACHANNEL);
    dna_paths = strcat(imagepaths, {', '}, dna_channel_numbers);
    %dnainds = ~cellfun(@isempty,regexp(imagepaths,'ch0'));
    %dnapaths = imagepaths(dnainds);
else
    dna_paths = {};
end

%%% get cell imagepaths
if $CELLCHANNEL ~= 0
    cell_channel_numbers = OME_getChannelNumbers(imagepaths, $CELLCHANNEL);
    cell_paths = strcat(imagepaths, {', '}, cell_channel_numbers);
    %cellinds = ~cellfun(@isempty,regexp(imagepaths,'ch1'));
    %cellpaths = imagepaths(cellinds);
else
    cell_paths = {};
end

%%% get prot image paths
if $PROTEINCHANNEL ~= 0
    protein_channel_numbers = OME_getChannelNumbers(imagepaths, $PROTEINCHANNEL)
    protein_paths = strcat(imagepaths, {', '}, protein_channel_numbers);
    %protinds = cellinds+dnainds<1;
    %protpaths = imagepaths(protinds);
else
    protein_paths = {};
end


%%% get image resolution and dimensionality
options.model.resolution = OME_getResolution(imagepaths{1});
if ~isempty(options.model.resolution)


    reader = bfGetReader(imagepaths{1});
    omeMeta = reader.getMetadataStore();
    if omeMeta.getPixelsSizeZ(0).getValue()>2
        dimensionality = '3D';
    else
        dimensionality = '2D';
    end
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

    answer = img2slml(dimensionality, dna_paths, cell_paths, protein_paths, options);
else
    disp('No resolution specified, exiting.')
end
exit;" > script.m

ln -s $CELLORGANIZER $(pwd)/cellorganizer
$MATLAB -nodesktop -nosplash -r "script;"

