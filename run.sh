#!/usr/bin/bash

# bash run.sh 




# queries="test-queries"
# results="t1"

queries="Queries"
results="test"
datafile="data2.txt"

############# Run Search Queries Documents #############

corpora="Documents Documents_raked"
goldset="Goldsets"

# echo "### TF-IDF ###"

# # tf-idf
# for c in $corpora; do
# 	echo "querying $c" 
# 	perl query_corpus.pl "$queries" "$c" "$results-tfidf-$c"
# done

# echo "#### IDF ####"

# # tf (no idf)
# for c in $corpora; do
# 	echo "querying $c" 
# 	perl query_corpus.pl "$queries" "$c" "$results-tf-$c" -noidf
# done

############# Generate Results for Documents #############

cat header.txt > $datafile
bash markSearches.sh $goldset $corpora >> $datafile

############# Run Search Queries Passages #############

corpora="Passages Passages_raked"
goldset="Goldsets_Passages"

# echo "### TF-IDF ###"

# # tf-idf
# for c in $corpora; do
# 	echo "querying $c" 
# 	perl query_corpus.pl "$queries" "$c" "$results-tfidf-$c"
# done

# echo "#### IDF ####"

# # tf (no idf)
# for c in $corpora; do
# 	echo "querying $c" 
# 	perl query_corpus.pl "$queries" "$c" "$results-tf-$c" -noidf
# done

############# Generate Results for Passages #############

#cat header.txt > $datafile # only do the first time
bash markSearches.sh $goldset $corpora >> $datafile


############# Generate Plots for everything #############

R CMD BATCH gen_plots.R