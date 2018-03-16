#!/bin/bash

export CELLORGANIZER=/usr0/home/icaoberg/alleninstitute/cellorganizer3
export PATH=$PATH:$(pwd)/bftools

if [ $# -eq 0 ]; then
	rsync -ruv tools/ galaxy/tools/
	cp tool_conf.xml galaxy/config
	rsync -ruv tours/*.yaml galaxy/config/plugins/tours/
	cd galaxy
	bash ./run.sh
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

		if [ -f bftools.zip ]; then
			rm -fv bftools.zip
		fi
		wget http://downloads.openmicroscopy.org/latest/bio-formats5.6/artifacts/bftools.zip
		unzip -o bftools.zip
		rm -fv bftools.zip

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
