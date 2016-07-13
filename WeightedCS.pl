use strict;
use warnings 'all';

use Text::Document;
use Text::DocumentCollection;

my $firstfile = shift @ARGV; 
my $secondfile = shift @ARGV;
my $thirdfile = shift @ARGV;

my%sp;
my $d1 = Text::Document->new;

open my $fh2, '<', $firstfile or die "Could not open file.";
while (my $line2 = <$fh2>) {
    chomp $line2;
    $line2 =~ s/[[:punct:]]//g;
    foreach my $str (split /\s+/, $line2) {
    	if (!defined $sp{lc($str)}) {
    			$d1 -> AddContent ($str);
    			}
    			}
    			}

my $d2 = Text::Document->new;
open my $fh3, '<', $secondfile or die "Could not open file.";
while (my $line2 = <$fh3>) {
    chomp $line2;
    $line2 =~ s/[[:punct:]]//g;
    foreach my $str (split /\s+/, $line2) {
    	if (!defined $sp{lc($str)}) {
    			$d2 -> AddContent ($str);
    			}
    			}
    			}

my $d3 = Text::Document->new;
open my $fh4, '<', $thirdfile or die "Could not open file.";
while (my $line2 = <$fh4>) {
    chomp $line2;
    $line2 =~ s/[[:punct:]]//g;
    foreach my $str (split /\s+/, $line2) {
    	if (!defined $sp{lc($str)}) {
    			$d3 -> AddContent ($str);
    			}
    			}
    			}
    			
my $c = Text::DocumentCollection->new( file => 'coll2.db' );

$c->Add('one',   $d1);
$c->Add('two',   $d2);
$c->Add('three', $d3);

for my $doc ( $d1, $d2, $d3 ) {

    my $wcs = $d1->WeightedCosineSimilarity(
        $doc,
        \&Text::DocumentCollection::IDF,
        $c
    );

    die qq{Invalid parameters for "WeightedCosineSimilarity"} unless defined $wcs;

    print $wcs, "\n";
}
