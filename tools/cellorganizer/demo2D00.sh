#!/usr/bin/env bash

export PATH=$PATH:$(dirname $0)

SEED=$1
NUMBER_OF_IMAGES=$2

if [ ! -f cellorganizer_v2.4.zip ]; then
	curl -o "cellorganizer_v2.4.zip" "http://cellorganizer.org/Downloads/v2.0/cellorganizer_v2.4.zip"
	unzip -o cellorganizer_v2.4.zip
	rm -fv cellorganizer_v2.4.zip
fi

cd cellorganizer_v2.4
/Applications/MATLAB_R2015a.app/bin/matlab -nodesktop -nosplash -r "setup(true);param.seed="$SEED";param.numberOfSynthesizedImages="$NUMBER_OF_IMAGES";demo2D00(param); pwd, copyfile( './images/demo2D00_1.tif', '../../../../' ); exit;"
