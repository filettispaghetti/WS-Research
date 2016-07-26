#!/usr/bin/bash # optional — to run, bash rake_passages.sh
files=`ls Documents`
mkdir -p Documents_raked

for f in $files; do
	echo Documents/$f
	echo Documents/$f | python rake.py > Documents_raked/$f
done