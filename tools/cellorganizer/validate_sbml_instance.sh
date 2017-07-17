#!/bin/bash
dataset=$1
echo ln -s $dataset ./file.xml
ln -s $dataset ./file.xml
zip -v file.zip file.xml
curl --silent -F file=@file.zip -F output=xml -F offcheck=u,r -F apikey='d40d197d-dee1-4275-baf8-44d6016915e2' http://sbml.org/validator/ 2>&1 >> output.txt
cat output.txt
