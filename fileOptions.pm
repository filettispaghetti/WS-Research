package fileOptions;

use strict;
use warnings;
use Text::Document;
use Text::DocumentCollection;
use Getopt::Long;
use Data::Dumper;

use Exporter qw(import);
our @EXPORT = qw(printFile countFreq cosineSim WeightedCS myTF myIDF myTFIDF log10 writeArray newText);

sub printFile{
	my ($file) = @_;
 	open (my $info, $file) or die "Could not open  file.";
		my $line ='';
		foreach $line (<$info>)  {   
			print $line;    
		}
	close($info);
	}
	
sub writeArray{
	my ($file) = @_;
	my @mylist;
	my %sp = stopWords();
	
	open (my $info, $file) or die "Could not open  file.";
		while (my $line = <$info>) {
  		  	chomp $line;
    		$line =~ s/[[:punct:]]//g;
    	foreach my $str (split /\s+/, $line) {
    		if (!defined $sp{lc($str)}) {
    			push(@mylist, $str);
		}}
		return @mylist;
}
}

sub newText{
	my (@array) = @_;	
	my %sp = stopWords();
 	my $t1 = Text::Document->new();
    	foreach my $str (@array) {
     			$t1 -> AddContent ($str);
		}
		return $t1;
	}	

  sub cosineSim{
	my(@array1, @array2) =@_;
	my $t1 = newText(@array1);
	my $t2 = newText(@array2);
		
	return $t1 ->CosineSimilarity( $t2 );
  }
  
sub WeightedCS{
	#takes query (array) and hash? (corpus)
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
}

sub myTF{
	#runs through hash; returns hash
	my (@array) =@_;
	
	# $count1 counts # of times a word is in document
	# $count2 counts the # of terms in document
	my $count1;
	my $count2;
	my %hash;

	#Assigns array to a hash
	%hash = map { $_ => 0 } @array;
	foreach (sort keys %hash) {
		$count2++;
   		print "$_ : $hash{$_}\n";
  	}
		print $count2;
		print "\n";
		
		for my $key (%hash) {
    		for my $key1 (%hash){
    			if (!($key eq "1") && ($key eq $key1)){
    				$hash{$key} += 1;
    				print "$key: $hash{$key} \n";
		}
		}
		}
		}
					
sub myIDF{
	my (@array, %corpus) =@_;
	my $count1 = 0;

	my %sp = stopWords();
	
	#Assigns array to a hash
	%hash = map { $_ => 0 } @array;
	foreach (sort keys %hash) {
   		print "$_ : $hash{$_}\n";
  	}
    		#instead of counting again, maybe take the count from myTF...
			#Ask Hill how to make a variable that could be used in both methods
    			if ($str eq $word){
    				$count1 ++;
    				last;
    				}
    				
    			if ($str2 eq $word){
    				$count1 ++;
    				last;
    				}
    				
    		my $x = (log10(2))/$count1;		
	return ($x);
}

sub myTFIDF{
	my ($file, $file2, $word) =@_;
	my $x = myTF($file, $file2);
	my $y = myIDF($file, $file2, $word);
	return $x * $y;
}

sub log10 {
  my $n = shift;
  return log($n)/log(10);
}

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