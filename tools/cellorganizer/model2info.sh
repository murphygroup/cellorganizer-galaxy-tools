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
slml2info( './model00001.mat' );
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

echo "Generating Markdown file"    
echo "# model2info tool output" > report.md

if [ -f show_shape_space.png ]; then
	convert -resize 50% show_shape_space.png thumbnail.jpg
	cp -v show_shape_space.png $TEMPORARY_FOLDER
	cp -v thumbnail.jpg $TEMPORARY_FOLDER
	echo "[![Shape space](thumbnail.jpg)](show_shape_space.png)" >> report.md
fi

if [ -f diary.txt ]; then
	echo "\`\`\`" >> report.md
	grep -v "diary off;" diary.txt > temp && mv temp diary.txt
	grep -v "slml2info( './model00001.mat' );" diary.txt > temp && mv temp diary.txt
	cat diary.txt >> report.md
	echo "\`\`\`" >> report.md
fi

if [ -f diary.txt ]; then
    cp -v diary.txt $TEMPORARY_FOLDER
fi

echo "Parsing Markdown file into HTML file"
pandoc report.md -o report.html
