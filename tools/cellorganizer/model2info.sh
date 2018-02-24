#!/bin/bash

model=$1
temporary_folder=$2

echo "Writing temporary file"
cat <<EOF >> script.m
tic;
current_directory = pwd; 
cellorganizer_directory = getenv('CELLORGANIZER'); 
cd( cellorganizer_directory ); 
setup(); 
cd( current_directory );
check_if_files_exist_on_disk_and_link_them_mat('$model');
load( './model00001.mat' ); 
diary diary.txt;
model2info( model );
diary off;
toc,
exit;
EOF

echo "Running Matlab script"
cat script.m | matlab -nodesktop
rm -fv script.m

echo "Generating Markdown file"    
echo "# model2info tool output" > report.md

if [ -f diary.txt ]; then
	echo "\`\`\`" >> report.md
	grep -v "diary off;" diary.txt > temp && mv temp diary.txt
	grep -v "model2info( model );" diary.txt > temp && mv temp diary.txt
	cat diary.txt >> report.md
	echo "\`\`\`" >> report.md
fi

echo "Making temporary folder "$temporary_folder
if [ ! -d $temporary_folder ]; then
        mkdir $temporary_folder
fi

if [ -f diary.txt ]; then
    cp -v diary.txt $temporary_folder
fi

echo "Parsing Markdown file into HTML file"
pandoc report.md -o report.html
