use strict;
use warning;
use Text::Document;
use Getopt::Long;
use fileOptions;

my $newfile = fileOptions -> new(shift @ARGV);
my $newfile2 = fileOptions -> new(shift @ARGV);

say $newfile -> printFile();
say $newfile2 -> printFile();

# say $newfile -> countFreq();
# say $newfile2 -> countFreq();
# 
# ##Still working on how to get this to work.
# # say $newfile -> cosineSim();
# # say $newfile2 -> cosineSim();
# 
# # say $newfile -> countLines();
# # say $newfile2 -> countLines();
# 
# 
# # Assign Stop Words
# # ##
# # ##
# # 
# # my %sp;
# # my $wordlist = 'StopWords.txt';
# # 
# # #my $sp = 0;
# # 
# # open my $sw, '<', $wordlist or die "Could not open file. $!";
# # while ($lin = <$sw>) {
# #     chomp $lin;
# #     foreach my $str (split /\s+/, $lin) {
# #         $sp{lc($str)} = 1;
# #         #print "$sp \n ";
# #     }
# # }
# 
# # my $firstfile = @ARGV; 
# # my $secondfile = @ARGV;
# 
# # if(!GetOptions(
# #     "firstfile",
# #     "secondfile=s"=> \$secondfile
# #     )
# #   )
# # {
# #     print "\nUnknown options have been provided\n";
# # }
# # $firstfile=join(" ",@ARGV);
# # print "First file is $firstfile and second file is $secondfile";

package fileOptions;

use strict;
use warnings;
use Text::Document;
use Getopt::Long;

sub new{
	my $class = shift;
	my $file = {
		file => shift
		};
bless $file;
return $file;
}

sub printFile{
	my ($file) = @_;
 	open (my $info, $file) or die "Could not open  file.";
		my $line ='';
		foreach $line (<$info>)  {   
			print $line;    
		}
	close($info);
	}
	
