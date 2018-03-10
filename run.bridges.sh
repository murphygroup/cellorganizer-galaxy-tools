#!/bin/bash

export CELLORGANIZER=/pylon5/bi5fpcp/icaoberg/allen_institute/cellorganizer3
export PATH=$PATH:/pylon5/bi5fpcp/icaoberg/allen_institute/bftools
export PATH=$PATH:/opt/packages/ffmpeg/3.1.1/bin
export PATH=$PATH:/opt/packages/pandoc/1.17.2/

if [ $# -eq 0 ]; then
	rsync -ruv tools/ galaxy/tools/
	cp tool_conf.xml galaxy/config
	cd galaxy
	bash ./run.sh --log-file /pylon5/bi5fpcp/icaoberg/allen_institute/cellorganizer-galaxy-tools/galaxy/galaxy.log
fi

if [ $# -eq 1 ]; then
	if [ "$1" == "install" ]; then
		git submodule init
		git submodule update
		cd galaxy
		git fetch --all
		git checkout release_17.09
		cd ..
		cp galaxy.ini galaxy/config
		cp tool_conf.xml galaxy/config
		cp datatypes_conf.xml galaxy/config
		rsync -ruv tool-data/ galaxy/tool-data # for future usage
		cp welcome.html galaxy/static/
		rsync -ruv tools/ galaxy/tools/
		cd galaxy
		bash ./run.sh
	fi

	if [ "$1" == "reinstall" ]; then
		rm -rfv galaxy
		mkdir galaxy
		git submodule init
		git submodule update
		cp galaxy.ini galaxy/config
		cp tool_conf.xml galaxy/config
		cp datatypes_conf.xml galaxy/config
		rsync -ruv tool-data/ galaxy/tool-data # for future usage
		cp welcome.html galaxy/static/
		rsync -ruv tools/ galaxy/tools/
		cd galaxy
		bash ./run.sh
	fi

	if [ "$1" == "clean" ]; then
		rm -rfv galaxy
		mkdir galaxy
	fi
fi
