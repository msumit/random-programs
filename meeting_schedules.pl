#/usr/local/bin/perl -w
#
# Given M busy-time slots of N people, You need to print all the available time slots when all the N people can schedule a meeting for a duration of K minutes.
# Event time will be of form HH MM ( where 0 <= HH <= 23 and 0 <= MM <= 59 ), K will be in the form minutes.
#  
# Input Format:
#  
# M K [ M number of busy time slots , K is the duration in minutes ]
# Followed by M lines with 4 numbers on each line.
# Each line will be of form StartHH StartMM EndHH EndMM  [ Example 9Am-11Am time slot will be given as 9 00 11 00 ]
# An event time slot is of form [Start Time, End Time ) . Which means it inclusive at start time but doesn’t include the end time. 
# So an event of form 10 00  11 00 => implies that the meeting start at 10:00 and ends at 11:00, so another meeting can start at 11:00.
#  
# Sample Input:
# 5 120
# 16 00 17 00
# 10 30 14 30
# 20 45 22 15
# 10 00 13 15
# 09 00 11 00
#  
# Sample Output:
# 00 00 09 00
# 17 00 20 45
# 
# Constraints :
# 1 <= M <= 100
#  
# Note: 24 00 has to be presented as 00 00.
#
# Read input from STDIN. Print output to STDOUT

my ($n, $k) = split(/\s/, <STDIN>);
my @arr;

for(0..1440){
  push @arr, 1;
}

for(1..$n){
  my($h1, $m1, $h2, $m2) = split(/\s/, <STDIN>);
  my $min = $h1*60 + $m1;
  my $min2 = $h2*60 + $m2;
  $min2 = 1440 unless($min2);
  #print "$min $min2 \n";
  for($min+1..$min2){
    $arr[$_] = 0;
  }
}

sub print{
  my $s = shift;
  my $e = shift;
  $e = 0 if($e == 1440);
  
  printf("%02d %02d %02d %02d \n", $s/60, $s%60, $e/60, $e%60);
}
my $start = 0;
my $end = 0;

for(my $i=1; $i<=1440; $i++){
  if($arr[$i] == 1 and $arr[$i-1] == 0){
    $start = $i-1; 
    $end = $i;
  }elsif($arr[$i] == 1){
    $end++;
  }elsif($arr[$i] == 0 and $arr[$i-1] == 1){
    &print($start, $end) if($end - $start >= $k);
    $start = $i;
    $end = $i;
  }
}
&print($start, $end) if($end - $start >= $k);