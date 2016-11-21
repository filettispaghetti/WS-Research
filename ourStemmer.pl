use Lingua::Stem::Snowball;
use strict;
use warnings;


#my @words = qw(wash washed washing washer); #test words here
  
#my @stems = stem( 'en', \@words ); 
#print (join(" ", @stems));
    
   # my @words = qw(wash washed washing washer);
   # my $stemmer = Lingua::Stem::Snowball->new( lang => 'en' );
   # $stemmer->stem_in_place( \@words ); # qw( hors hoov )

    #print (join(" ", @words), "\n");
    
    
    
my $filetostem = shift @ARGV;
my @array;
open(FILE, "<", $filetostem)
    or die "Failed to open file: $!\n";
while(<FILE>) { 
    my @words = split(' ', $_);
    push @array, @words;
} 
close FILE;
	
	my $stemmer = Lingua::Stem::Snowball->new( lang => 'en' );
    $stemmer->stem_in_place( \@array ); # qw( hors hoov )
    print (join(" ", @array), "\n");
    
