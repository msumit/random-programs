#/usr/local/bin/perl -w
#
# Given a 2–d matrix , which has only 1’s and 0’s in it. Find the total number of connected sets in that matrix.
# Connected set can be defined as group of cell(s) which has 1 mentioned on it and have at least one other cell in that set with which they share the neighbor relationship.
#
# Input format : First line of the input contains T , number of test-cases. Then follow T testcases. Each testcase has given format.
# N [ representing the dimension of the matrix N X N ]. Followed by N lines , with N numbers on each line.
#
# Ouput format : For each test case print one line ,  number of connected component it has.
#
# Sample Input :
# 2
# 4
# 0 0 1 0
# 1 0 1 0
# 0 1 0 0
# 1 1 1 1
# 4
# 1 0 0 1
# 0 0 0 0
# 0 1 1 0
# 1 0 0 1
#
# Sample output :
# 1
# 3
#
# Constraint :
# 0 < T < 6 
# 0 < N < 1009 

# Read input from STDIN. Print output to STDOUT

my $t = <STDIN>;
my @a;
my $n;

sub mark{
  my $x = shift;
  my $y = shift;
  #print "received $x, $y \n";
  #<STDIN>;
  $a[$x][$y] = 0;
  
  if($x == 0 && $y == 0){
    &mark(1,0) if($a[1][0]);
    &mark(1,1) if($a[1][1]);
    &mark(0,1) if($a[0][1]);
  }elsif($x == 0 && $y < $n-1){
    &mark(0, $y-1) if($a[0][$y-1]);
    &mark(0, $y+1) if($a[0][$y+1]);
    &mark(1, $y-1) if($a[1][$y-1]);
    &mark(1, $y) if($a[1][$y]);
    &mark(1, $y+1) if($a[1][$y+1]);  
  }elsif($x == 0 && $y == $n-1){
    &mark(0,$y-1) if($a[0][$y-1]);
    &mark(1,$y-1) if($a[1][$y-1]);
    &mark(1,$y) if($a[1][$y]);  
  }elsif($x < $n-1 && $y == 0){
    &mark($x-1, 0) if($a[$x-1][0]);
    &mark($x-1, 1) if($a[$x-1][1]);
    &mark($x, 1) if($a[$x][1]);
    &mark($x+1, 0) if($a[$x+1][0]);
    &mark($x+1, 1) if($a[$x+1][1]);
  }elsif($x == $n-1 && $y == 0){
    &mark($x-1,0) if($a[$x-1][0]);
    &mark($x-1,1) if($a[$x-1][1]);
    &mark($x,1) if($a[$x][1]);    
  }elsif($x == $n-1 && $y < $n-1){
    &mark($x-1, $y-1) if($a[$x-1][$y-1]);
    &mark($x, $y-1) if($a[$x][$y-1]);
    &mark($x-1, $y) if($a[$x-1][$y]);
    &mark($x-1, $y+1) if($a[$x-1][$y+1]);
    &mark($x, $y+1) if($a[$x][$y+1]);  
  }elsif($x == $n-1 && $y == $n-1){
    &mark($x-1, $y-1) if($a[$x-1][$y-1]);
    &mark($x-1, $y) if($a[$x-1][$y]);
    &mark($x, $y-1) if($a[$x][$y-1]);  
  }elsif($x < $n-1 && $y == $n-1){
    &mark($x-1, $y-1) if($a[$x-1][$y-1]);
    &mark($x, $y-1) if($a[$x][$y-1]);
    &mark($x+1, $y-1) if($a[$x+1][$y-1]);
    &mark($x-1, $y) if($a[$x-1][$y]);
    &mark($x+1, $y) if($a[$x+1][$y]);    
  }else{
    &mark($x-1, $y-1) if($a[$x-1][$y-1]);
    &mark($x, $y-1) if($a[$x][$y-1]);
    &mark($x+1, $y-1) if($a[$x+1][$y-1]);
    &mark($x-1, $y) if($a[$x-1][$y]);
    &mark($x+1, $y) if($a[$x+1][$y]); 
    &mark($x-1, $y+1) if($a[$x-1][$y+1]);
    &mark($x, $y+1) if($a[$x][$y+1]);
    &mark($x+1, $y+1) if($a[$x+1][$y+1]);      
  }
}

while($t--){
  $n = <STDIN>;
  @a = ();
  my ($i, $j, $c) = (0, 0, 0);
  
  for(1..$n){
    push @a, [split(/\s/, <STDIN>)];
  }
  
  for($i=0; $i<$n; $i++){
    for($j=0; $j<$n; $j++){
        next unless($a[$i][$j]);
        $c++;
        &mark($i, $j);        
    }
  }
  print $c,"\n";
}