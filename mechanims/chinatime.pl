#!/use/bin/env perl
# 将世界标准时间转为北京时间

use strict;
use warnings;
use Time::Local;
use POSIX qw/strftime/;
use File::Basename qw/basename dirname/;
use List::Util qw/max min/;
use Date::Calc qw/Add_Delta_Days/;

my $usage = "Usage: perl $0 inputfile(.gcmt) \n";
@ARGV ==1 or die "$usage";
my $eqtfile = $ARGV[0];

open(IN, "< $eqtfile");
my @lines = <IN>;
chomp(@lines);
close(IN);

open(EQT,"> newout.txt") or die "can not build file eat-file";
my $i=0;
my ($year,$mon,$mday,$hour,$min,$sec,$msec,$lat,$lon,$dep,$mag);
my ($date,$time,$mmsec);
my @dist;
my $line;
  my $gmt_time;
while($i<@lines){

	($date,$time,@dist)=split /\s+/,$lines[$i];
	
	($year,$mon,$mday) = split /\//,$date;
	($hour,$min,$msec) = split /\:/,$time;
    ($sec,$mmsec) = split /\./,$msec;
    $mon = $mon-1;
    $gmt_time=timelocal("$sec","$min","$hour","$mday","$mon","$year")+8*3600 ;

    $year = strftime "%Y",localtime($gmt_time);
    $mday = strftime "%d",localtime($gmt_time);
	$mon=strftime "%m",localtime($gmt_time);

	$hour = strftime "%H",localtime($gmt_time);
#    $min=strftime "%M",localtime($gmt_time);
#    $sec=strftime "%S",localtime($gmt_time);
	#$mon=$mon; 

    print "$year/$mon/$mday $hour:$min:$sec @dist \n";               
    print EQT "$year/$mon/$mday $hour:$min:$sec @dist \n";
	    $i++;
}

close(EQT);


#    our $year = substr($lines[$i],0,4);
#    $year = sprintf("%04d", $year);
#    our $mon  = substr($lines[$i],5,2);
#    $mon = sprintf("%02d", $mon);
#    our $mday = substr($lines[$i],8,2);
#    $mday = sprintf("%02d", $mday);
#    our $hour = substr($lines[$i],11,2);
#    $hour = sprintf("%02d", $hour);
#    our $min  = substr($lines[$i],14,2);
#    $min = sprintf("%02d", $min);
#   our $sec = substr($lines[$i],17,2);
#    $sec = sprintf("%02d", $sec);