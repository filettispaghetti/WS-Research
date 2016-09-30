#!/usr/bin/bash # optional — to run, bash rake_passages.sh
#files=`ls Documents`
files=`ls Passages`
#mkdir -p Documents_raked
mkdir -p Passages_raked

for f in $files; do
	#echo Documents/$f
	#echo Documents/$f | python rake.py > Documents_raked/$f
	echo Passages/$f
	echo Passages/$f | python rake.py > Passages_raked/$f
done