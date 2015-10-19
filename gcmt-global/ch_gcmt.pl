#!/usr/bin/perl
use warnings;
use strict;

my $usage="perl $0 lon_min lon_max lat_min lat_max";
@ARGV >= 4 or die "Usage:$usage \n ";
our $lon_min = $ARGV[0];
our $lon_max = $ARGV[1];
our $lat_min = $ARGV[2];
our $lat_max = $ARGV[3];

open(IN,"< jan1976_apr2015.dat") or die "open global_gcmt.dat failed ";
open(OUT,"> mec.out") or die "can not build out.dat";
while(<IN>){
    our ($date,$time,$lon,$lat,@other)= split /\s+/;
    if( $lon >= $lon_min && $lon <= $lon_max && $lat >= $lat_min && $lat <= $lat_max){
        print OUT "$date $time $lon $lat @other \n";
    }
}
close(OUT);
close(IN);