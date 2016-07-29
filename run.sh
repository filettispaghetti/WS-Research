#!/usr/bin/bash

# bash run.sh 

corpora="Documents Documents_raked"
queries="test-queries"
queries="Queries"

############# Run Search Queries #############

# tf-idf
for c in $corpora; do
	echo "querying $c" 
	perl query_corpus.pl "$queries" "$c" "test-tfidf-$c"
done

# tf (no idf)
for c in $corpora; do
	echo "querying $c" 
	perl query_corpus.pl "$queries" "$c" "test-tf-$c"
done

############# Generate Results #############

cat header.txt > data.txt
bash markSearches.sh >> data.txt

############# Generate Plots #############

R CMD BATCH gen_plots.R