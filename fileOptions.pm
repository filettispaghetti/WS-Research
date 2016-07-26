package fileOptions;

use strict;
use warnings;
use Text::Document;
use Text::DocumentCollection;
use Getopt::Long;
use Data::Dumper;

use Exporter qw(import);
our @EXPORT = qw(printFile countFreq cosineSim WeightedCS myTF myIDF myTFIDF log10 writeArray newText);

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

#Takes file name and rewrites to an array	
sub writeArray{
	my ($file) = @_;
	my @mylist;
	my %sp = stopWords();
	
	open (my $info, $file) or die "Could not open  file.";
		while (my $line = <$info>) {
  		  	chomp $line;
#get rid of punctuation
	   		$line =~ s/[[:punct:]]//g;
    	foreach my $str (split /\s+/, $line) {
#takes out stopwords    		
    		if (!defined $sp{lc($str)}) {
#writes to array
    			push(@mylist, $str);
		}}
		return @mylist;
}
}

#new text document
sub newText{
	my (@array) = @_;	
	my %sp = stopWords();
 	my $t1 = Text::Document->new();
    
#adds each element of the array to a text document    
    	foreach my $str (@array) {
     			$t1 -> AddContent ($str);
		}
		return $t1;
	}	

#not fixed since switched from files to arrays
# (if needed, cosine sim still works on tester)
  sub cosineSim{
	my(@array1, @array2) =@_;
	my $t1 = newText(@array1);
	my $t2 = newText(@array2);
		
	return $t1 ->CosineSimilarity( $t2 );
  }
  
#takes query (array) and corpus (hash) and returns hash with WCS values
#not fixed since switched from files to arrays.
sub WeightedCS{
	my(@query, %corpus) =@_;
	my $query = newText($file);
	
	
	my $c = Text::DocumentCollection->new( file => 'coll2.db' );

# 	$c->Add('one',   $t1);
# 	$c->Add('two',   $t2);
# 	$c->Add('three', $t3);

    	
    
    die qq{Invalid parameters for "WeightedCosineSimilarity"} unless defined $wcs;
    # printf("'%8.4f'\n\n", $wcs);
    print $wcs;
    print "\n";
}

#takes array and returns hash
sub myTF{
	my (@array) =@_;
	my $count;
	my %hash;

	#Assigns array to a hash
	%hash = map { $_ => 0 } @array;
	foreach (sort keys %hash) {
# $count counts the # of terms in document		
		$count++;
   		print "$_ : $hash{$_}\n";
  	}
		
#takes loops through keys and compares them to the same hashes keys		
		for my $key (%hash) {
    		for my $key1 (%hash){
# "1" keeps returning as a key and seems to be the only key that counts successfully??
#why? i dont know.
    			if (!($key eq "1") && ($key eq $key1)){
#adds 1 to $key if the keys equal, meaning they have occurred $key amount of times    				
    				$hash{$key} += 1;
    				print "$key: $hash{$key} \n";
		}
		}
		}
#goes through each key and divides key's value by count \\\ TF = term frequency/terms in doc		
		for my $key (%hash){
			$hash{$key} = ($hash{$key})/$count;
		}
		
		return %hash;
		}

#a mess, a big mess
#not complete still fixing hashes.				
sub myIDF{
	my (@query, %corpus) =@_;
	my $count1 = 0;
	my $count2 = 0;
  	
# number of keys in %corpus
	foreach $key in %corpus{
		$count1 ++;
		}

#Assigns query array to a hash
	%myhash = map { $_ => 0 } @query;
	foreach (sort keys %myhash) {
   		print "$_ : $myhash{$_}\n";
  	}

#counts up for every document that has a $key in it 	
	for my $key1 (%myhash){
		for my $key2 (%corpus){
#still have to fix inside if statement
			if ($key1 is in $key2){					
					$count2 ++;
    				last;
    				}
    				}
#IDF = log_e( # of docs / # of docs w/ term)
    	%myhash{$key1} = (log10($count1))/$count2;
		}
		} 		
	return %myhash;	
}

#not yet fixed since switched from files to arrays
sub myTFIDF{
	my ($file, $file2, $word) =@_;
	my $x = myTF($file, $file2);
	my $y = myIDF($file, $file2, $word);
	return $x * $y;
}

#for use of myIDF
sub log10 {
  my $n = shift;
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