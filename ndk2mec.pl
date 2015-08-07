#junlysky.info@gmail.com
#!/usr/bin/env perl
use warnings;
use strict;

my $usage="perl $0 infile(.ndk) outfile ";
@ARGV > 0 or die "$usage \n";
my $infile=$ARGV[0];
my $outfile=$ARGV[1];
open(IN,"< $infile") or die "open $infile err :$!";
our @lines = <IN> ;
chomp(@lines);
close(IN);
open(OUT,"> $outfile") or die "err build $outfile:$!";
  print OUT "date time lon lat dep Mb Ms strike1 dip1 rake1 strike2 dip2 rake2  mrr mtt mpp mrt mrp mtp p_trend p_plu p_eigen b_trend b_plu b_eigen t_trend t_plu t_eigen scale exponent event_name \n";


our $i=0;
our $count=0;

our $date;
our $time;
our $lat; 
our $lon;
our $dep;
our $mag_mb;
our $mag_ms;
our $name;
our $time_tamp;
our $expond;
our $mrr;
our $mtt;
our $mpp;
our $mrt;
our $mrp;
our $mtp;
our $p_eigen;
our $p_plu;
our $p_trend;
our $b_eigen;
our $b_plu;
our $b_trend;
our $t_eigen;
our $t_plu;
our $t_trend;
our $scale;
our $str1;
our $dip1;
our $rake1;
our $str2;
our $dip2;
our $rake2;

our @line ;

while($i<@lines){
    @line = split /\s+/,$lines[$i];
    $count = $i%5 ;
#    printf "$count  @line \n";
    if($count == 0){
        $date = $line[1];
        $time = $line[2];
        $lat = $line[3];
        $lon = $line[4];
        $dep = $line[5];
        $mag_mb = $line[6];
        $mag_ms = $line[7];
    }
    elsif( $count ==1 ){
        $name = $line[0];
    }
    elsif( $count == 2 ){
         $time_tamp = $line[10];
 #       $time_tamp = substr($time_tamp,0,1);
    }
    elsif( $count == 3 ){
        $expond = $line[0];
        $mrr = $line[1];
        $mtt = $line[3];
        $mpp = $line[5];
        $mrt = $line[7];
        $mrp = $line[9];
        $mtp = $line[11];
 # r is up ,t is south, p is east; 
    }
    elsif( $count == 4){
        $p_eigen=$line[1];
        $p_plu=$line[2];
        $p_trend=$line[3];
        $b_eigen=$line[4];
        $b_plu=$line[5];
        $b_trend=$line[6];
        $t_eigen=$line[7];
        $t_plu=$line[8];
        $t_trend=$line[9];
        $scale=$line[10];
        $str1=$line[11];
        $dip1=$line[12];
        $rake1=$line[13];
        $str2=$line[14];
        $dip2=$line[15];
        $rake2=$line[16];

        print  OUT "$date $time $lon $lat $dep $mag_mb $mag_ms $str1 $dip1 $rake1 $str2 $dip2 $rake2 $ mrr $mtt $mpp $mrt $mrp $mtp $p_trend $p_plu $p_eigen $b_trend $b_plu $b_eigen $t_trend $t_plu $t_eigen $scale $expond $name \n";
    }
#    else die "something is err:$!";
    $i++;
}
close(OUT);

