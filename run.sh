#!/bin/bash

cp galaxy.ini galaxy/config
cp tool_conf.xml galaxy/config
cd galaxy
./run.sh
