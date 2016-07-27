#use strict;
use warnings;

use Text::Document;
use Text::DocumentCollection;
use fileOptions;
use Data::Dumper;

# perl Comparison.pl TestA.txt

my $file = shift @ARGV;
my @a = writeArray($file);
print join(" ", @a), "\n";
my %words = myTF(@a);
print Dumper(\%words);

# my $file2 = 'Corpus10/1559CommonPrayer.txt';
# my @b = writeArray($file2);
# print @b;
# 
# my $file3 = 'Corpus10/adulterousMariages.txt';
# my @b = writeArray($file2);
# print @b;
# 
# my $file4 = 'Corpus10/AYL.txt';
# my @c = writeArray($file2);
# print @c;
# 
# my $file5 = 'Corpus10/ConfessionofWitches.txt';
# my @d = writeArray($file2);
# print @d;
# 
# my $file6 = 'Corpus10/Ham.txt';
# my @e = writeArray($file2);
# print @e;
# 
# my $file7 = 'Corpus10/LetterDukeAlba.txt';
# my @f = writeArray($file2);
# print @f;
# 
# my $file8 = 'Corpus10/LetterPrinceParma.txt';
# my @g = writeArray($file2);
# print @g;
# 
# my $file9 = 'Corpus10/Mac.txt';
# my @h = writeArray($file2);
# print @h;
# 
# my $file10 = 'Corpus10/TheaterLittleWorld.txt';
# my @i = writeArray($file2);
# print @i;

#my $file3 = 
# my $file2 = shift @ARGV;
#  my @y = writeArray($file2);

# my $file3 = shift @ARGV;

# my $word = "Texas";


# print "\n";
# print (myIDF($file, $file2, $word));
# print "\n";
# print (myTFIDF($file, $file2, $word));
# print "\n"; 

# printFile($newfile);
# printFile($newfile2);

# newText(@x);

# print "Cosine Similarity is: "; 
# cosineSim(@x, @y);
# print "\n";

# print "Weighted Cosine Similarity is: \n";
# print WeightedCS(@query, %corpus);
# print "\n";