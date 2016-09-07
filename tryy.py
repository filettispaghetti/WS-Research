import os
indir = '/Users/Victorine/Desktop/WS/Documents'
for root, dirs, filenames in os.walk(indir):
    for f in filenames:
    	print f
       # log = open(f, 'r')