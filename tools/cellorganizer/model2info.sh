#!/bin/bash

echo "Generating Markdown file"    
echo "# model2info tool output" > report.md

if [ -f diary.txt ]; then
	echo "\`\`\`" >> report.md
	cat diary.txt >> report.md
	echo "\`\`\`" >> report.md
fi

echo "Making temporary folder "$1
if [ ! -d $1 ]; then
        mkdir $1
fi

if [ -f diary.txt ]; then
    cp -v diary.txt $1
fi

echo "Parsing Markdown file into HTML file"
pandoc report.md -o report.html