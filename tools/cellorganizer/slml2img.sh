#!/usr/bin/env bash

data=$1
options_synthesis=$2
compression=$3
seed=$4

echo "Writing temporary file"
cat << EOF >> script.m
tic;
current_directory = pwd;
cellorganizer_directory = getenv('CELLORGANIZER');
cd( cellorganizer_directory );
setup();
cd( current_directory );

options.seed = $seed;
options.targetDirectory = current_directory;
options.prefix = 'imgs';
options.compression = '$compression';
options.debug = false;
options.display = false;
options.synthesis = '$options_synthesis';
options.output.tifimages = false;
options.output.OMETIFF = true;
options.numberOfSynthesizedImages = 5;
filenames = strsplit('$data', ',');

check_if_files_exist_on_disk_and_link_them_mat('$data');
diary diary.txt;
answer = slml2img(filenames, options);
diary off;
toc;
exit;
EOF

echo "Running Matlab script"
cat script.m | matlab -nodesktop
rm -fv script.m
