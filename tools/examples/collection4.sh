#!/bin/bash

NUMBER=$(((RANDOM%10)+1))

for ((I=1; I <= $NUMBER; I++));
do
	echo $I >> cell$I.txt
done

ls -lt 