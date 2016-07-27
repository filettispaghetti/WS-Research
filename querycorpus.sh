#!/usr/bin/bash # optional — to run, bash rake_passages.sh
files=`ls Corpus10`
queries=`ls Queries`
mkdir -p querycorpusscores

for q in $queries; do
	for f in $files; do
		#echo Corpus10/$f
		echo Corpus10/$f | perl query_corpus.pl f q > querycorpusscores/$f$q
	done
done