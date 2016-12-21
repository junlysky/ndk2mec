#!/usr/bin/perl
use strict;

# by junlysky.info@gmail.com

my $usage="perl $0 inputfile(.gcmt) lon_min lon_max lat_min lat_max";
@ARGV == 5 or die "Usage:$usage \n ";
our $gcmtfile = $ARGV[0]
our $lon_min = $ARGV[1];
our $lon_max = $ARGV[2];
our $lat_min = $ARGV[3];
our $lat_max = $ARGV[4];

open(IN,"< $gcmtfile") or die "open .gcmt failed ";
open(OUT,"> new.out") or die "can not build out.dat";
while(<IN>){
    our ($date,$time,$lon,$lat,@other)= split /\s+/;
    if( $lon >= $lon_min && $lon <= $lon_max && $lat >= $lat_min && $lat <= $lat_max){
        print OUT "$date $time $lon $lat @other \n";
    }
}
close(OUT);
close(IN);
