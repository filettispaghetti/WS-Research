#!/usr/bin/bash # optional — to run, bash rake_passages.sh
dirs=`ls Desktop/WS/*`
mkdir -p documents_raked

for d in $dirs; do
	files=`ls Documents/$d/*.txt`
	for f in $files; do
		#echo passages/$d/$f
		echo pssages/$d/$f | python rake.py > documents_raked/$d/$f
	done
done