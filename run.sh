#!/bin/bash

export CELLORGANIZER=/Users/icaoberg/Desktop/cellorganizer3
export PATH=$PATH:./bftools

if [ $# -eq 0 ]; then
	rsync -ruv tools/ galaxy/tools/
	cp tool_conf.xml galaxy/config
	cd galaxy
	bash ./run.sh
fi

if [ $# -eq 1 ]; then
	cp galaxy.ini galaxy/config
	cp tool_conf.xml galaxy/config
	cp datatypes_conf.xml galaxy/config
	rsync -ruv tool-data/ galaxy/tool-data # for future usage
	cp welcome.html galaxy/static/
	rsync -ruv tools/ galaxy/tools/
	cd galaxy
	bash ./run.sh
fi
