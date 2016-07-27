use warnings;
use fileOptions;
use Data::Dumper;

# takes as input a query directory and a corpus directory
# perl query_corpus.pl test-queries Corpus10
# perl query_corpus.pl queries test-queries

# TODO Need to add a results dir that we remove
# TODO debug mulitple docs in test-queries (add one more)

my $query_dir = shift @ARGV;
my $corpus_dir = shift @ARGV;
#my $results_dir = shift@ARGV;

#`rm -rf $results_dir`;

my %numDocs = (); 	# maps term to number of documents it's in
my %idf = ();		# idf values for each word in corpus
my %tf = ();
my %terms = (); 	# for each document in corpus, for each term in doc, returns freq
my %doc_normal = ();

# initial setup
# foreach file in the corpus
foreach my $fp (glob("$corpus_dir/*.txt")) {
	# build a giant hash of word frequencies
	# and document frequencies

	printf "Counting ... %s\n", $fp;

	my @list = writeArray($fp);	# getting list of words from doc
	%words = myTF(@list);		# counting tf
	$terms{"$fp"} = \%words;	# storing in giant hash, indexed by file

	# Updating the numDoc hash
	for my $w (keys %words) {
		$numDocs{$w}++;
	}
}

# calculate IDF
print "Calculating IDF\n";
%idf = myIDF(%numDocs);
#print Dumper(\%numDocs);
#print Dumper(\%idf);

# Calculate Normalization for each doc
# to do: make function
for my $key (keys %idf) {
	for my $doc (keys %terms) {
		next if (!defined $terms{$doc}{$key});
		$tfidf = log(1 + $terms{$doc}{$key}) * $idf{$key};
		$doc_normal{$doc} += $tfidf * $tfidf;
		$tf{$doc}{$key} = $tfidf;
	}
}

# take the square root
for my $key (keys %doc_normal) {
	$doc_normal{$key} = sqrt($doc_normal{$key});
}

# print("terms: \n");
# print Dumper(\%terms);
# print("idf: \n");
# print Dumper(\%idf);
# print("tf-idf: \n");
# print Dumper(\%tf);

# run all the queries
# foreach file in the query folder
foreach my $fq (glob("$query_dir/*.txt")) {
	printf "Counting query ... %s\n", $fq;
	# count word frequencies
	my @list = writeArray($fq);	# getting list of words from doc
	my %query = myTF(@list);		# counting tf
	#print Dumper(\%query);

	# calculate cosine similarity between every doc in corpus
	my $norm = 0; # denominator
	
	for $qw (keys %query) {
		$tfidf = log(1 + $query{$qw}) * ((defined $idf{$qw}) ? $idf{$qw} : 0);
		$norm += $tfidf * $tfidf;
	}
	$norm = sqrt($norm);
	for $doc (keys %tf) {
		my $dot = 0;
		for $qw (keys %query) {
			$tfidf = log(1 + $query{$qw}) * ((defined $idf{$qw}) ? $idf{$qw} : 0);
			$dot += $tfidf * ((defined $tf{$doc}{$qw}) ? $tf{$doc}{$qw} : 0);
		}
		print("$dot / $norm * $doc_normal{$doc} = \n");
		my $score = $dot / ($norm * $doc_normal{$doc});
		print("$score\t$doc\n"); # open an out file
	}
	
}
