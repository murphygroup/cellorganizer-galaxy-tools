function answer=train_model(MASKCHANNEL,DNACHANNEL,CELLCHANNEL,PROTEINCHANNEL,TRAINFLAG,MODELNAME,MODELID,DOWNSAMPLEX,DOWNSAMPLEY,DOWNSAMPLEZ,NUCLEUSTYPE,NUCLEUSNAME,NUCLEUSCLASS,NUCLEUSID,CELLTYPE,CELLNAME,CELLCLASS,CELLID,PROTEINTYPE,PROTEINNAME,PROTEINCLASS,PROTEINID,PROTEINCYTONUCLEARFLAG,DOCUMENTATION,VERBOSE,DEBUG)
% function answer=train_model()
answer = false;
WORKING_DIRECTORY=pwd;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK
cd ~/CellOrganizor/build/cellorganizer3
setup();
cd(WORKING_DIRECTORY);
options.targetDirectory = WORKING_DIRECTORY;
% current_path = which(mfilename);
% [current_path, filename, extension] = fileparts( current_path );
% cd(current_path);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% parse varargin
options.train.flag = TRAINFLAG; %nuclear, frame, all %% add a default in the shell script so train.flag is always var 3
options.downsampling = [str2num(DOWNSAMPLEX) str2num(DOWNSAMPLEY) str2num(DOWNSAMPLEZ)];
options.nucleus.type = NUCLEUSTYPE; % medial axis, cylindrical surface or diffeo
options.nucleus.class = NUCLEUSCLASS; % nuc or framework
options.cell.type = CELLTYPE;
options.cell.class = CELLCLASS;
options.protein.type = PROTEINTYPE;
options.protein.class = PROTEINCLASS;
options.protein.cytonuclearflag = PROTEINCYTONUCLEARFLAG;
options.verbose = str2bool(VERBOSE);
options.debug = str2bool(DEBUG);
options.model.name = MODELNAME; %same as above, optional
options.model.filename = [MODELNAME '.mat'];
options.model.id = MODELID; %random string%
options.nucleus.name = NUCLEUSNAME; %defualt to empty
options.nucleus.id = NUCLEUSID;
options.cell.name = CELLNAME;
options.cell.id = CELLID;
options.protein.name = PROTEINNAME;
options.protein.id = PROTEINID;
options.documentation.name = DOCUMENTATION;
if strcmpi(options.model.id, '')
    options.model.id = num2str(now);
end
if strcmpi(options.cell.id, '')
    options.cell.id = num2str(now);
end
if strcmpi(options.nucleus.id, '')
    options.nucleus.id = num2str(now);
end
if strcmpi(options.protein.id, '')
    options.protein.id = num2str(now);
end
%%%
% options.train.flag = 'all'; 
% options.downsampling = [5 5 1];
% options.nucleus.type = 'cylindrical_surface'; 
% options.nucleus.class = 'nuclear_membrane'; 
% options.cell.type = 'ratio';
% options.cell.class = 'cell_membrane';
% options.protein.type = 'gmm';
% options.protein.class = 'vesicle';
% options.protein.cytonuclearflag = 'cyto';
% options.verbose = true;
% options.debug = false;
% options.model.filename = ['model.mat'];
% options.model.name = num2str(now);
% options.model.id = num2str(now);
% options.nucleus.name = num2str(now); 
% options.nucleus.id = num2str(now);
% options.cell.name = num2str(now);
% options.cell.id = num2str(now);
% options.protein.name = num2str(now);
% options.protein.id = num2str(now);
% options.documentation.name = num2str(now);
% MASKCHANNEL=4;
% DNACHANNEL=1;
% CELLCHANNEL=2;
% PROTEINCHANNEL=3;

%% pares image data
directory=WORKING_DIRECTORY;
files = dir([directory filesep '*.ome.tif']);
files = sort_nat({files.name});
for i = 1:length(files)
    dna{i} = @() flipdim(OME_loadchannel([directory filesep files{i}],DNACHANNEL),3);
    cell{i} = @() flipdim(OME_loadchannel([directory filesep files{i}],CELLCHANNEL),3);
    protein{i} = @() flipdim(OME_loadchannel([directory filesep files{i}],PROTEINCHANNEL),3);
    masks{i} = @() flipdim(OME_loadchannel([directory filesep files{i}],MASKCHANNEL),3);
end
options.masks = masks;

%%% get image resolution and dimensionality
options.model.resolution = OME_getResolution([directory filesep files{1}]);
if ~isempty(options.model.resolution)
    reader = bfGetReader([directory filesep files{1}]);
    omeMeta = reader.getMetadataStore();
    if omeMeta.getPixelsSizeZ(0).getValue()>2
        dimensionality = '3D';
    else
        dimensionality = '2D';
    end
    answer = img2slml(dimensionality, dna, cell, protein, options);
else
    disp('No resolution specified, exiting.')
end

end

function bool=str2bool(str)
    if strcmpi(str,'false')
        bool = false;
    end
    if strcmpi(str,'true')
        bool = true;
    end
end