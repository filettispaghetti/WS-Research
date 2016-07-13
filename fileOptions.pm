package fileOptions;

use strict;
use warnings;
use Text::Document;
use Getopt::Long;

use Exporter qw(import);
our @EXPORT = qw(printFile countFreq cosineSim WeightedCS);

sub printFile{
	my ($file) = @_;
 	open (my $info, $file) or die "Could not open  file.";
		my $line ='';
		foreach $line (<$info>)  {   
			print $line;    
		}
	close($info);
	}
	
sub newText{
	my ($file) = @_;
	my %count1;
	
	# Assign Stop Words
	my %sp;
	my $wordlist = 'StopWords.txt';
	my $lin;

	open my $sw, '<', $wordlist or die "Could not open file. $!";
		while ($lin = <$sw>) {
    		chomp $lin;
    	foreach my $str (split /\s+/, $lin) {
       		$sp{lc($str)} = 1;
        #print "$sp \n ";
    	}
		}
		
 	my $t1 = Text::Document->new();
 	
	open (my $info, $file) or die "Could not open  file.";
		while (my $line = <$info>) {
  		  	chomp $line;
    		$line =~ s/[[:punct:]]//g;
    	foreach my $str (split /\s+/, $line) {
    		if (!defined $sp{lc($str)}) {
    			$count1{lc($str)} += 1;
    			$t1 -> AddContent ($str);
		}}}
		return $t1;
	}
	
sub cosineSim{
	my($file, $file2) =@_;
	my $t1 = newText($file);
	my $t2 = newText($file2);
		
	my $sim = $t1->CosineSimilarity( $t2 );
		return $sim;
  }
  
sub WeightedCS{
	my($file, $file2, $file3) =@_;
	my $t1 = newText($file);
	my $t2 = newText($file2);
	my $t3 = newText($file3);
	
	my $c = Text::DocumentCollection->new( file => 'coll2.db' );

	$c->Add('one',   $t1);
	$c->Add('two',   $t2);
	$c->Add('three', $t3);

	for my $doc ($t1, $t2, $t3) {

   		 my $wcs = $t2->WeightedCosineSimilarity(
       		$doc,
        	\&Text::DocumentCollection::IDF,
        	$c
    	);
    	
    
    die qq{Invalid parameters for "WeightedCosineSimilarity"} unless defined $wcs;
    # printf("'%8.4f'\n\n", $wcs);
    print $wcs;
    print "\n";
}
}
  

# sub countLines{
# 	my($file) = @_;
# 	open(FILE, "<file.txt") or die "Could not open file: $!";
# 
# 	my ($lines, $words, $chars) = (0,0,0);
# 
# 	while (<FILE>) {
#   		$lines++;
#    		$chars += length($_);
#     	$words += scalar(split(/\W+/, $_));
# 	}
# 
# 	print("lines=$lines words=$words chars=$chars\n");
#   }
  
