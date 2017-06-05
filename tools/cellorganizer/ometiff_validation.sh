#!/bin/bash
if ! $bftools/xmlvalid $1 | grep -q "No validation errors found."; then
    exit -1
else
	cp $1 pwd
	exit 0
fi