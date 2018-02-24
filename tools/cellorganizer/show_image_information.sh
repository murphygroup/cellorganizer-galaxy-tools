#!/bin/bash

ln -s $1 ./img.ome.tif

echo "# OME.TIFF Image Information" > report.md
echo "## File type information" >> report.md
echo "\`\`\`" >> report.md
echo file ./img.ome.tif >> report.md
file ./img.ome.tif >> report.md
echo "\`\`\`" >> report.md

echo "## OME.TIFF Image Information" >> report.md
echo "\`\`\`" >> report.md
echo showinf -nopix ./img.ome.tif >> report.md
showinf -nopix ./img.ome.tif >> report.md
echo "\`\`\`" >> report.md

echo "Parsing Markdown file into HTML file"
pandoc report.md -o report.html

