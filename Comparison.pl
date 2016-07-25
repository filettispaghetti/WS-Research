use strict;
use warnings 'all';

use Text::Document;
use Text::DocumentCollection;
use fileOptions;
use lib '/Users/rebeccafiletti/lib/';

my $file = shift @ARGV;
my @x = writeArray($file);

# my $file2 = shift @ARGV;
#  my @y = writeArray($file2);

# my $file3 = shift @ARGV;

# my $word = "Texas";

myTF(@x);
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


# print countLines($file);
# print countLines($file2);