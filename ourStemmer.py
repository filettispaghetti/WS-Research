use Lingua::Stem::Snowball;

my @words = qw(dying dies death); #test words here
   
my @stems = stem( 'en', \@words ); 
print (join(" ", @stems));
   
    my $stemmer = Lingua::Stem::Snowball->new( lang => 'en' );
    $stemmer->stem_in_place( \@words ); # qw( hors hoov )

    print (join(" ", @words), "\n");