from PIL import Image
import sys
import os
import re
import subprocess

input_tiff = sys.argv[1]
pic_num = int(sys.argv[2])
output_prev = sys.argv[3]
## by doing this we can get rid of the path 
head, output_prev = os.path.split(output_prev)
print output_prev, 'mamama'
im = Image.open(input_tiff)
cmd = 'mkdir tmp'
os.system(cmd)


for i in range(pic_num):
	im.seek(i)
	im.save('tmp/' + str(i) + '.jpg', 'JPEG')

cmd = 'zip -r ' + output_prev + ' tmp'
os.system(cmd)
cmd = 'mv ' + output_prev + ' ' + head
os.system(cmd)
