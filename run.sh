#!/usr/bin/bash # optional — to run, bash rake_passages.sh
corpora="Documents Documents_raked"
# files=`ls Documents`
queries=`ls test-queries`
mkdir -p querycorpusscores
for c in corpora; do
	for doc in c; do
		for q in $queries; do
# 		#echo Corpus10/$f
 			perl query_corpus.pl q doc  querycorpusscores/$c$doc
 		done
 	done
done