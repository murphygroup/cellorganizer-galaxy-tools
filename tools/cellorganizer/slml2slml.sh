#!/bin/bash

# @icaoberg inherit script filename
SCRIPT=$1
#2>/dev/null
cat $SCRIPT | matlab -nodesktop -nosplash
rm -fv $SCRIPT

# @icaoberg check if file exists on disk. if it does not, then exit with error code
if [ ! -f model.mat ]; then
	echo "File does not exist."
	exit -1
fi
