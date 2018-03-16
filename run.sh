#!/bin/bash

export CELLORGANIZER=/usr0/home/icaoberg/alleninstitute/cellorganizer3
export PATH=$PATH:./bftools

if [ $# -eq 0 ]; then
	rsync -ruv tools/ galaxy/tools/
	cp tool_conf.xml galaxy/config
	cp core.dl_model_from_repo.yaml galaxy/config/plugins/tours
	cp core.import_ometiff.yaml galaxy/config/plugins/tours
	cp core.upload_from_computer.yaml galaxy/config/plugins/tours
	cp core.show_image_info.yaml galaxy/config/plugins/tours
	cp core.validate_ometiff.yaml galaxy/config/plugins/tours	
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
