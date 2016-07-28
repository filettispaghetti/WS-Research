package fileOptions;

#use strict;
use warnings;
use Text::Document;
use Text::DocumentCollection;
use Getopt::Long;
use Data::Dumper;

use Exporter qw(import);
our @EXPORT = qw(myTF myIDF log10 writeArray); #run again and time difference

#Takes a file and prints it.
sub printFile{
	my ($file) = @_;
 	open (my $info, $file) or die "Could not open  file.";
		my $line ='';
		foreach $line (<$info>)  {   
			print $line;    
		}
	close($info);
	}

#Takes file and rewrites to an array of words	
sub writeArray{
	my ($file) = @_;
	my @mylist;
	my %sp = stopWords();
	
	open (FILE, $file) or die "Could not open file: $!";
	while (my $line = <FILE>) {
		chomp $line;
		
		#get rid of punctuation
   		$line =~ s/[[:punct:]]//g;
	
		foreach my $str (split /\s+/, $line) {
			#takes out stopwords
			my $lower = lc($str);		
			if (!defined $sp{$lower}) {
				#writes to array
				push(@mylist, $lower);
			}
		}	
	}
	close FILE;
	return @mylist;
}

# #new text document
# sub newText{
# 	my (%words) = @_;	
# 	#my %sp = stopWords();
#  	my $t1 = Text::Document->new();
    
# #adds each element of the array to a text document    
#     	foreach my $str (keys %words) {
#     		for my i (1..$words{$str}) {
#      			$t1 -> AddContent ($str);
#      		}
# 		}
# 		return $t1;
# 	}	

# sub newText{
# 	my (%words) = @_;	
# 	#my %sp = stopWords();
#  	my $t1 = Text::Document->new();
    
# #adds each element of the array to a text document    
#     	foreach my $str (keys %words) {
#     		for my i (1..$words{$str}) {
#      			$t1 -> AddContent ($str);
#      		}
# 		}
# 		return $t1;
# 	}	

# #not fixed since switched from files to arrays
# # (if needed, cosine sim still works on tester)
#   sub cosineSim{
# 	my(%words1, %words2) =@_;
# 	my $t1 = newText(@array1);
# 	my $t2 = newText(@array2);
		
# 	return $t1 ->CosineSimilarity( $t2 );
#   }
  
#takes query (array) and corpus (hash) and returns hash with WCS values
#not fixed since switched from files to arrays.
# sub WeightedCS{
# 	my(@query, %corpus) =@_;
# 	my $query = newText($file);
	
	
# 	my $c = Text::DocumentCollection->new( file => 'coll2.db' );

# # 	$c->Add('one',   $t1);
# # 	$c->Add('two',   $t2);
# # 	$c->Add('three', $t3);

    	
    
#     die qq{Invalid parameters for "WeightedCosineSimilarity"} unless defined $wcs;
#     # printf("'%8.4f'\n\n", $wcs);
#     print $wcs;
#     print "\n";
# }

#takes array and returns hash
sub myTF{
	my (@array) = @_;
	#print(@array, "\n");
	my %hash = map { $_ => 0 } @array; # Initializes frequencies in hash to 0
	my $count = scalar @array; # total words
		
	# counts frequency of each word in doc	
	for my $key (@array) {
			$hash{$key} += 1;
	}
	#goes through each key and divides key's value by count \\\ TF = term frequency/terms in doc		
	for my $key (keys %hash){
		$hash{$key} = $hash{$key} / $count;
	}

	return %hash;
}

#a mess, a big mess
#not complete still fixing hashes.				
sub myIDF{
	my (%corpus) =@_; # hash of words => number of docs (doc frequency)
	my %idf = ();
	my $count = scalar keys %corpus; # number of docs

	# calculate IDF 	
	for my $key (keys %corpus){
		#IDF = log_e( # of docs / # of docs w/ term)
    	$idf{$key} = log10($count / $corpus{$key});
	}
	 		
	return %idf;	
}

#not yet fixed since switched from files to arrays
# sub myTFIDF{
# 	my ($file, $file2, $word) = @_;
# 	my $x = myTF($file, $file2);
# 	my $y = myIDF($file, $file2, $word);
# 	return $x * $y;
# }

#for use of myIDF
sub log10 {
  my ($n) = @_;
  return log($n)/log(10);
}

#assigns text file to hash of stopwords
sub stopWords{
	my %sp;
	my $wordlist = 'StopWords.txt';
	my $lin;

	open my $sw, '<', $wordlist or die "Could not open file. $!";
	while ($lin = <$sw>) {
		chomp $lin;
		foreach my $str (split /\s+/, $lin) {
   			$sp{lc($str)} = 1;
		}
	}
	return %sp;
}