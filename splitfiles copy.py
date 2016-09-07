import os

#original
chunksize = 50
fid = 1
with open('Mac.txt') as infile:
    f = open('file%d.txt' %fid, 'w')
    for i,line in enumerate(infile):
        f.write(line)
        if not i%chunksize:
            f.close()
            fid += 1
            f = open('file%d.txt' %fid, 'w')
    f.close()