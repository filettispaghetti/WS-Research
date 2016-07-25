use strict;
use warnings;
use File::Find;
use Data::Dumper;

my $directory = '/Users/rebeccafiletti/Desktop/DSSI:DSHI/CORPUS';
my @corpus;

find(sub {
    push @corpus, $File::Find::name;
}, $directory );

print "Processing $_"
    for @corpus;
    
    print "\n";
    dump @corpus;
    
#     my $x;
# 	undef($/);
# 	my @cArray;
# 		for ($x=1;$x<4;$x++){
# 			open(INPUT,"<$x\.txt");
# 				while(<INPUT>){
# 	  			$cArray[$x-1]=$_;
# 			}
# 			close INPUT;
# 		}
# 		for (@cArray){
# 			print "$_";
# 			print "-------\n";
# 		}