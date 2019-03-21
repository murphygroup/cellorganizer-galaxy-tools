#!/bin/bash

MODEL=$1
TEMPORARY_FOLDER=$2

echo "Writing temporary file"
cat << EOF >> script.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY THIS BLOCK
tic;
current_directory = pwd;
cellorganizer_directory = getenv('CELLORGANIZER');
cd( cellorganizer_directory );
setup();
cd( current_directory );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

check_if_files_exist_on_disk_and_link_them_mat('$MODEL');
load( './model00001.mat' );

if is_diffeomorphic( model )
	options.nlabels = 5;
	options.traces = 0;
	options.subsize = 750;

	show_shape_space_figure_galaxy_wrapper( './model00001.mat', options );
end



diary diary.txt;

%Load multiple models if tcell model
if is_tcell_model(model)
	files=dir(fullfile('.','*.mat'));
	models = fullfile('.', {files.name});
	slml2info(models);

	%Change name of file to show_enrichment.png
	img_name=ml_ls('report/*model_mean_enrichment_plot_mdl*.png');
	I = imread( img_name{1} );
	imwrite( I, 'report/show_enrichment.png' );

else
	slml2info({'./model00001.mat'});
end

diary off;
toc,
exit;
EOF

echo "Running Matlab script"
cat script.m | matlab -nodesktop
#rm -fv script.m

echo "Making temporary folder "$TEMPORARY_FOLDER
if [ ! -d $TEMPORARY_FOLDER ]; then
        mkdir $TEMPORARY_FOLDER
fi

if [ -f report/show_shape_space.png ]; then
    cp -v report/show_shape_space.png $TEMPORARY_FOLDER
fi

if [ -f report/show_shape_space_thumbnail.png ]; then
    cp -v report/show_shape_space_thumbnail.png $TEMPORARY_FOLDER
fi

if [ -f report/show_shape_evolution_thumbnail.png ]; then
    cp -v report/show_shape_evolution_thumbnail.png $TEMPORARY_FOLDER
fi

if [ -f report/show_shape_evolution.png ]; then
    cp -v report/show_shape_evolution.png $TEMPORARY_FOLDER
fi

if [ -f report/show_enrichment.png ]; then
    cp -v report/show_enrichment.png $TEMPORARY_FOLDER
fi
