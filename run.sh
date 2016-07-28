#!/usr/bin/bash # optional — to run, bash rake_passages.sh
corpora="Documents Documents_raked"
# files=`ls Documents`
#queries=` test-queries`
#mkdir -p querycorpusscores
for c in $corpora; do
	echo "querying $c" 
	perl query_corpus.pl test-queries $c testout-$c
done