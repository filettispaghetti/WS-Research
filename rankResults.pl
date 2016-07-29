#!/usr/bin/perl -w

# AOC

my $infile = shift @ARGV;
my $rfile = shift @ARGV; # rank results
my $cfile = shift @ARGV;
my $ofile = shift @ARGV;
my $pfile = shift @ARGV;

my $query = shift @ARGV;
my $corpora = shift @ARGV;
my $tech = shift @ARGV;

my $n = `wc -l $cfile`;
$n =~ s/^\s*(\d+)\D.*$/$1/;
chomp $n;
#chomp $n;

# print "$n $query\n";
# exit;

# Get gold set
my $gold = 0;
my %sigs = ();

open(FILE, "$cfile") or die "$cfile $!\n";
while (my $line = <FILE>) {
	next if $line =~ /^#?\s*$/;
	next if $line =~ /^\s*$/;
	chomp $line;
	$sigs{$line} = 1;
	$gold++;
}
close FILE;

# Get ranks & calcualte MAP
my $returned = 0;
my $tp = 0;
my $map = 0;
my $mrr = 0;

open(FILE, "cat $infile | sort -rn |") or die "$infile $!\n";
open(OUT, ">$rfile") or die "$rfile $!\n";
open(MOUT, ">$ofile") or die "$ofile $!\n";
open(PRF, ">$pfile") or die "$pfile $!\n";

my $rank = 1;
my $seen = 0;
my $last = -1;
my $marked = 0;

print PRF sprintf("#%5s %5s %3s %3s    %-22s %-22s %-20s\n", "rank", "ret", "tp", "rank-rel",
	"Precision", "Recall", "F Measure");



while (my $line = <FILE>) {
	chomp $line;
	next if $line =~ /^#?\s*$/;
	next if $line =~ /^\s*$/;
	if ($line =~ /^\s*(-?[0-9\.]+)\s+(\S+)\s*$/) {
		my $score = $1;
		my $elem = $2;
		
		my $pline = sprintf("%6s $line\n", $rank);
		
		# get rank
		if ($last == -1) {
			# first time thru
			$last = $score;
		} elsif ($score ne $last) {
			
			# PRF for MAP calc for PRIOR rank
			# only print when new rank
			my $p = 0;
			my $r = 0;
			my $f = 0;
			
			if ($returned > 0) {
				$p = $tp / $returned;
			}
			
			if ($gold > 0) {
				$r = $tp / $gold;
			}
			
			if ($p > 0 || $r > 0) {
				$f = (2*$p*$r) / ($p+$r);
			}
			
			#my $fp = $returned - $tp;
			#my $tn = ($n - $returned) - ($gold - $tp);
			
			$last = sprintf("%5s %5s %3s %3s    %05.18f %05.18f %05.18f\n", $rank, $returned,
				$tp, $marked, ($p*100), ($r*100), ($f*100));
			print PRF $last;
			
			$map += $marked * $p if ($marked > 0); # MAP only for relevant ranks

			$mrr = 1.0 / $rank if ($mrr == 0);
			
			# then this is a new rank
			$rank += $seen;
			$rank = $n if ($score <= 0);
			$seen = 0;
			$marked = 0;
			$last = $score;
			$pline = sprintf("%6s $line\n", $rank);
		}
		
		# update seen & output rank line
		$returned++;
		$tp++ if (defined $sigs{$elem});
		$seen++;
		print OUT $pline;
		
		# Marked search
		my $mark = " ";	
		if (defined $sigs{$elem}) {
		 	$mark = "*";
		 	$marked++;
		}
		$pline = sprintf("%6s $mark$line\n", $rank);
		print MOUT $pline;
		
	}
}

# PRF for MAP calc for PRIOR rank
# only print when new rank
my $p = 0;
my $r = 0;
my $f = 0;

if ($returned > 0) {
	$p = $tp / $returned;
}

if ($gold > 0) {
	$r = $tp / $gold;
}

if ($p > 0 || $r > 0) {
	$f = (2*$p*$r) / ($p+$r);
}

#my $fp = $returned - $tp;
#my $tn = ($n - $returned) - ($gold - $tp);
	
$last = sprintf("%5s %5s %3s %3s    %05.18f %05.18f %05.18f\n", $rank, $returned,
	$tp, $marked, ($p*100), ($r*100), ($f*100));
print PRF $last;

$map += $marked * $p if ($marked > 0); # MAP only for relevant ranks

close FILE;
close OUT;

$map = $map / $tp if $tp > 0;

print "$tech-$corpora $query $p $r $f $map $mrr\n";


