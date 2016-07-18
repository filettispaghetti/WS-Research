package fileOptions;

# use strict;
use warnings;
use Text::Document;
use Getopt::Long;

use Exporter qw(import);
our @EXPORT = qw(printFile countFreq cosineSim WeightedCS myTF myIDF myTFIDF log10);

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
	
	my %sp = stopWords();
		
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

sub myTF{
	my ($file, $word) =@_;
	my $count1;
	my $count2;

	my %sp = stopWords();
	
	open my $fh, '<', $file or die "Could not open file. $!";
		while (my $line = <$fh>) {
    		chomp $line;
    		$count2 ++;
    		$line =~ s/[[:punct:]]//g;
   		foreach my $str (split /\s+/, $line) {
    		if (!defined $sp{lc($str)}) {
    			# print "$str \n";
    			if (defined $word){
    				$count1 ++;
    				}
    				}
    				}
    				}
    				# print "$count1 \n";
#     				print "$count2 \n";
					return $count2/$count1;	
	}
	
sub myIDF{
	my ($file, $file2, $word) =@_;
	my $count1 = 0;

	my %sp = stopWords();
	
	open my $fh, '<', $file or die "Could not open file. $!";
		while (my $line = <$fh>) {
    	chomp $line;
    	$line =~ s/[[:punct:]]//g;
   		foreach my $str (split /\s+/, $line) {
    	if (!defined $sp{lc($str)}) {
    			if ($str eq $word){
    				$count1 ++;
    				last;
    				}}}}
    			
    open my $fh2, '<', $file2 or die "Could not open file. $!";
		
		while (my $line2 = <$fh2>) {
    		chomp $line2;
    		$line2 =~ s/[[:punct:]]//g;
   		foreach my $str2 (split /\s+/, $line2) {
    		if (!defined $sp{lc($str2)}) {
    			if ($str2 eq $word){
    				$count1 ++;
    				last;
    				}}}}
    				
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