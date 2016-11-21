#!/usr/bin/bash # optional — to run, bash rake_passages.sh
#files=`ls Documents`
files=`ls Passages`
#mkdir -p Documents_raked
mkdir -p Passages_stemmed
corpora="Passages"

for f in $files; do
	#echo Documents/$f
	#echo Documents/$f | python rake.py > Documents_raked/$f
	echo Passages/$f
	echo Passages/$f | perl ourStemmer.pl > Passages_stemmed/$f
done