#!/usr/bin/bash

# bash run.sh 

corpora="Documents Documents_raked"
queries="test-queries"
results="t1"
queries="Queries"
results="test"

############# Run Search Queries #############

echo "### TF-IDF ###"

# tf-idf
for c in $corpora; do
	echo "querying $c" 
	perl query_corpus.pl "$queries" "$c" "$results-tfidf-$c"
done

echo "#### IDF ####"

# tf (no idf)
for c in $corpora; do
	echo "querying $c" 
	perl query_corpus.pl "$queries" "$c" "$results-tf-$c" -noidf
done

############# Generate Results #############

cat header.txt > data.txt
bash markSearches.sh >> data.txt

############# Generate Plots #############

R CMD BATCH gen_plots.R