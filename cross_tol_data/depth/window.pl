use warnings;
use strict;

# Script adds together the depth of coverage in blocks given by $ARGV[2] and writes to a comma delimited file $ARGV[1],
# which should specify the window length.
# Note this is not a sliding window, just a block.
#
# Input should be a raw.txt file from samtools pileup program.
open(IN,$ARGV[0]);
my @snpdata = <IN>;
close(IN);

my $window = $ARGV[2];
# print "$window\n";

open(OUTDEPTH, ">$ARGV[1]");

my @keepsnp;
my @keepindel;
my $windowcount = 0;
my $depth = 0.0;

print OUTDEPTH "CHR,BASE,DEPTH\n";

foreach my $test0 (@snpdata){
chomp $test0;
my @newarray = split(/\t/,$test0);
my $newtype = $newarray[2];
if($newtype ne '*'){
$windowcount += 1;
$depth += $newarray[3]/$window;
# print "$depth\n";
if($windowcount eq $window){
# print "cleared\n";
print OUTDEPTH "$newarray[0],$newarray[1],$depth\n";
$windowcount = 0;
$depth = 0.0;
};
};
};

close OUTDEPTH;
exit;
