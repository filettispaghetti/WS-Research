import os

#original
chunksize = 16
fid = 1
with open('Sonnetss.txt') as infile:
    f = open('Sonet%d.txt' %fid, 'w')
    for i,line in enumerate(infile):
        f.write(line)
        if len(line.strip()) == 0 :
            f.close()
            fid += 1
            f = open('Sonet%d.txt' %fid, 'w')
    f.close()