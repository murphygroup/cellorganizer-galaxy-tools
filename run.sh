#!/bin/bash

export CELLORGANIZER=/Users/icaoberg/Desktop/cellorganizer3
export PATH=$PATH:./bftools

cp galaxy.ini galaxy/config
cp tool_conf.xml galaxy/config
cp datatypes_conf.xml galaxy/config
rsync -ruv tools/ galaxy/tools/
rsync -ruv tool-data/ galaxy/tool-data # for future usage
cp welcome.html galaxy/static/

cd galaxy
which showinf
./run.sh
