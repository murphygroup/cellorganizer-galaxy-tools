#!/bin/bash

if ! $bftools/xmlvalid $1 | grep -q "No validation errors found."; then
    error="Errors found in the ometiff file !"
    echo $error
fi