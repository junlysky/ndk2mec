#!/usr/bin/env perl
use warnings;
use strict;

# the fist line must be headline 
my $usage = "Usage: perl $0 inputfile(.gcmt) \n";
@ARGV ==1 or die "$usage";
my $gcmtfile = $ARGV[0];
open(IN, "< $gcmtfile") or die "Can not open the file gcmt_dat";
#open(IN,"< jan1976-aug2016.gcmt") or die "Can not open the file gcmt_dat";
our @lines = <IN>;

chomp(@lines);
close(IN);
open(NF,"> nf.dat ") or die "formal.dat is err to build";
open(NS,"> ns.dat") or die "fs.dat is err to build";
open(SS,"> ss.dat") or die "strike.dat is err to build";
open(TF,"> tf.dat") or die "ns.dat is err to build ";
open(TS,"> ts.dat") or die "normal.dat is err to build";
open(UN,"> un.dat") or die "unknow.dat is err to build";

my $i=0;
while($i< @lines){
    $lines[$i]=~s/^\s+//;
	$lines[$i]=~//g;
# for pbt.out
#        our ($lon,$lat,$str1,$dip1,$rake1,$str2,$dip2,$rake2,$m1,$m2,$m3,$m4,$m5,$m6,$p_tr,$p_plu,$b_tr,$b_plu,$t_tr,$t_plu,$dep,$mag) = split /\s+/,$lines[$i];
#lon     lat    str1    dip1   rake1    str2    dip2   rake2     mrr     mtt     mpp     mrt     mrp     mtp p-trend   p-plu b-trend   b-plu t-trend   t-plu dep mag
#for gcmt.dat
#date time lon lat depth Mb Ms strike1 dip1  rake1  strike2  dip2  rake2   mrr  mtt  mpp  mrt  mrp  mtp  p_azi  p_plu  p_eigen  b_azi  b_plu  b_eigen  t_azi  t_plu  t_eigen  scale  exponent  name 
our ($date,$time,$lon,$lat,$dep,$mb,$ms,$str1,$dip1,$rak1,$str2,$dip2,$rak2,$m1,$m2,$m3,$m4,$m5,$m6,$p_tr,$p_plu,$p_gen,$b_tr,$b_plu,$b_gen,$t_tr,$t_plu,$t_gen,$scale,$exponent,$name) = split /\s+/,$lines[$i];
# date time lon lat depth Mb Ms strike1 dip1  rake1  strike2  dip2  rake2   mrr  mtt  mpp  mrt  mrp  mtp  p_azi  p_plu  p_eigen  b_azi  b_plu  b_eigen  t_azi  t_plu  t_eigen  scale  exponent  name    
# perl中有更简洁的语句实现上一个语句
    if ($p_plu >= 52 && $t_plu <= 35){
           print NF "$lines[$i] \n";
    }
    elsif ($p_plu >= 40 && $p_plu < 52 && $t_plu <= 20 ){
           print NS "$lines[$i]\n";
    }
    elsif ($p_plu < 40 && $b_plu >= 45 && $t_plu <= 20){
            print SS "$lines[$i]\n";
    } 
    elsif ($p_plu <= 20 && $b_plu >=45 && $t_plu <40 ){
           print SS "$lines[$i]\n";
    }
    elsif ($p_plu <= 20 && $t_plu >=40 && $t_plu <= 52 ){
        print TF "$lines[$i]\n";
    }
    elsif ($p_plu <= 35 && $t_plu >=52 ){
        print TS "$lines[$i]\n";
    }
    else {
        print UN  "$lines[$i]\n";
    }
    print "$p_plu   $b_plu   $t_plu  \n";
    $i++;
    
}
close(NF);
close(NS);
close(SS);
close(TF);
close(TS);
close(UN);