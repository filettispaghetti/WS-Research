use strict;
use warnings;
use Text::Document;
use Text::DocumentCollection;
use Getopt::Long;

my $firstfile = shift @ARGV; 
my $secondfile = shift @ARGV;
my %sp;

#STOP WORDS
##
##
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

#Initiating new Text::Document object
##
##
my %count1;

print "\n First File \n";
my $t1 = Text::Document->new();
open my $fh, '<', $firstfile or die "Could not open file. $!";
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

# Count Frequency of Words for Second File
##
##
print "\n Second File \n";

my %count2;
my $t2 = Text::Document->new();

open my $fh2, '<', $secondfile or die "Could not open file.";
while (my $line2 = <$fh2>) {
    chomp $line2;
    #$t2 -> AddContent ( $line2);
    $line2 =~ s/[[:punct:]]//g;
    foreach my $str (split /\s+/, $line2) {
    	if (!defined $sp{lc($str)}) {
    			$count2{lc($str)} += 1;
    			$t2 -> AddContent ($str);
}}}
 my $word2 = 0;
foreach my $word2 (reverse sort { $count2{$a} <=> $count2{$b} } keys %count2) {
    printf "%-31s %s\n", $word2, $count2{$word2};
}

#Cosine Similarity
##
##
print "\n";
my $sim = $t1->CosineSimilarity( $t2 );
print "Cosine Sim is: $sim\n";


# my $listRef = $t1->KeywordFrequency();
#   foreach my $pair (@{$listRef}){
#         my ($term,$frequency) = @{$pair};
#         print "Frequency of $term is $frequency\n";
#   }
#   print "\n";
#   my $listRef2 = $t2->KeywordFrequency();
#   foreach my $pair (@{$listRef2}){
#         my ($term,$frequency) = @{$pair};
#         print "Frequency of $term is $frequency\n";
#   }

#Weighted Similarity
##
##
# my $collection = Text::DocumentCollection->new(file => 'coll.db');
# $collection ->Add("One", $firstfile);
# $collection ->Add("Two", $secondfile);
# 
# my $wSim = $t1->WeightedCosineSimilarity( $t2,
#         \&Text::DocumentCollection::IDF,
#         $collection);
# # print "Weighted Cosine Sim is: $wSim\n";

