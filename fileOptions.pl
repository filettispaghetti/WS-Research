package Comparison::fileOptions;

use strict;
use warnings;
use Text::Document;
use Getopt::Long;

sub new{
	my $file = shift;
	}
	
bless $file;
return $file;
	
sub printFile{
	my ($file) = @_;
 	open (my $info, $file) or die "Could not open  file.";
		my $lin ='';
		foreach $line (<$info>)  {   
			print $line;    
		}
	close($info);
	}
	
sub countFreq{
	my ($file) = @_;
	my %count1;

 		my $t1 = Text::Document->new();
	open my $fh, '<', $file or die "Could not open file. $!";
		while (my $line = <$fh>) {
  		  	chomp $line;
    	$line =~ s/[[:punct:]]//g;
    	foreach my $str (split /\s+/, $line) {
    		if (!defined $sp{lc($str)}) {
    			$count1{lc($str)} += 1;
    			$t1 -> AddContent ($str);
		}}}
	my $word = 0;
	foreach my $word (reverse sort { $count1{$a} <=> $count1{$b} } keys %count1) {
   		printf "%-31s %s\n", $word, $count1{$word};
	}
}

sub cosineSim{
	my($file) =@_;
	my $sim = $t1->CosineSimilarity( $t2 );
		print "$sim\n";

	my $listRef = $t1->KeywordFrequency();
  		foreach my $pair (@{$listRef}){
        	my ($term,$frequency) = @{$pair};
        	print "$term, $frequency\n";
  		}
  	print "\n";
  	my $listRef2 = $t2->KeywordFrequency();
  	foreach my $pair (@{$listRef2}){
      	  my ($term,$frequency) = @{$pair};
        	print "$term, $frequency\n";
  	}
  }

sub countLines{
	my($file) = @_;
	open(FILE, "<file.txt") or die "Could not open file: $!";

	my ($lines, $words, $chars) = (0,0,0);

	while (<FILE>) {
  		$lines++;
   		$chars += length($_);
    	$words += scalar(split(/\W+/, $_));
	}

	print("lines=$lines words=$words chars=$chars\n");
  }
  
1;