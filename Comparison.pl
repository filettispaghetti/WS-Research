use strict;
use warnings 'all';

use Text::Document;
use Text::DocumentCollection;
use fileOptions;
use lib '/Users/rebeccafiletti/lib/';

my $file = shift @ARGV;
my $file2 = shift @ARGV;
# my $file3 = shift @ARGV;

my $word = "Texas";

print (myTF($file, $word));
print "\n";
print (myIDF($file, $file2, $word));
print "\n";
print (myTFIDF($file, $file2, $word));
print "\n"; 

# printFile($newfile);
# printFile($newfile2);

# print newText($file);
# print newText($file2);

# print "Cosine Similarity is: "; 
# print cosineSim($file, $file2);
# print "\n";

# print "Weighted Cosine Similarity is: \n";
# print WeightedCS($file, $file2, $file3);
# print "\n";


# print countLines($file);
# print countLines($file2);