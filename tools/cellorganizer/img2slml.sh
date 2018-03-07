#!/bin/bash

SCRIPT=$1
cat $SCRIPT | matlab -nodesktop -nosplash
rm -fv $SCRIPT
