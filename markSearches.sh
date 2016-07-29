#!/bin/bash

# bash markSearches.sh > data.txt

corpora="Documents Documents_raked"

techniques="tf tfidf"

gold="Goldsets"
ext=".txt"
outdir="results"

mkdir -p $outdir

for c in $corpora; do
	for t in $techniques; do
		config="test-$t-$c"
		indir="$config"
		odir="$outdir/$config/marked_search"
		pdir="$outdir/$config/prf_results"
		rankdir="$outdir/$config/rank_results"

		mkdir -p $odir $pdir $rankdir
	
		files=`ls $indir`

		for f in $files; do
			q=`basename $f $ext`
			#echo -n "$queries $q"
			#echo $f $q 
			perl rankResults.pl $indir/$f $rankdir/$f $gold/$f $odir/$f $pdir/$f $q $c $t
		done
	done
done
