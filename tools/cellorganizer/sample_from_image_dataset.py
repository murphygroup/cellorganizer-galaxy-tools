#!/usr/bin/env python

import sys

datafile = sys.argv[1]
numimgs = float(sys.argv[2])

if numimgs<0:
	numimgs = 0

with open(datafile, 'r') as f:
	dat = list(f.read().splitlines())

if numimgs<len(dat):
	dat = dat[:int(numimgs)]

with open('output.txt','w') as f:
	for path in dat:
		f.write(path)
		f.write('\n')