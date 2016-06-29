use strict;
use warnings;
use Text::Document;
use Getopt::Long;
use lib 'lib';
use Comparison::fileOptions;

my $newfile = new Comparison::fileOptions(@ARGV);
my $newfile2 = new Comparison::fileOptions(@ARGV);

say $newfile -> printFile();
say $newfile2 -> printFile();

say $newfile -> countFreq();
say $newfile2 -> countFreq();

##Still working on how to get this to work.
# say $newfile -> cosineSim();
# say $newfile2 -> cosineSim();

say $newfile -> countLines();
say $newfile2 -> countLines();


# Assign Stop Words
##
##

my %sp;
my $wordlist = 'StopWords.txt';

#my $sp = 0;

open my $sw, '<', $wordlist or die "Could not open file. $!";
while ($lin = <$sw>) {
    chomp $lin;
    foreach my $str (split /\s+/, $lin) {
        $sp{lc($str)} = 1;
        #print "$sp \n ";
    }
}

# my $firstfile = @ARGV; 
# my $secondfile = @ARGV;

# if(!GetOptions(
#     "firstfile",
#     "secondfile=s"=> \$secondfile
#     )
#   )
# {
#     print "\nUnknown options have been provided\n";
# }
# $firstfile=join(" ",@ARGV);
# print "First file is $firstfile and second file is $secondfile";