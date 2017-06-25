#!/bin/bash

NUMBER=$(((RANDOM%10)+1))

for ((I=1; I <= $NUMBER; I++));
do
	echo $I >> cell$I.txt
done

mkdir $1
mkdir files

cp -v *.txt files/
cp -v *.txt $1

ls -lt 