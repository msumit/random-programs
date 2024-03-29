#/usr/local/bin/perl -w
#
# Given a number K, find the smallest Fibonacci number that shares a common factor( other than 1 ) with it. A number is said to be a common factor of two numbers if it exactly divides both of them. 
# Output two separate numbers, F and D, where F is the smallest fibonacci number and D is the smallest number other than 1 which divides K and F.
# 
# Input Format : First line of the input contains an integer T, the number of testcases. Then follows T lines, each containing an integer K.
# 
# Output Format : Output T lines, each containing the required answer for each corresponding testcase.
#
# Sample Input   
# 3
# 3
# 5
# 161
# 
# Sample Output
# 3 3
# 5 5
# 21 7
# 
# Explanation :  There are three testcases. The first test case is 3, the smallest required fibonacci number  3. The second testcase is 5 and the third is 161. For 161 the smallest fibonacci numer sharing a common divisor with it is 21 and the smallest number other than 1 dividing 161 and 7 is 7.
# 
# Constraints : 
# 1 <= T <= 5
# 2 <= K <= 1000,000
# The required fibonacci number is guranteed to be less than 10^18.
# Time Limit : 16sec
#
# Read input from STDIN. Print output to STDOUT

my $t = <STDIN>;
my @arr = (1,1);

for(2..97){
  push @arr, ($arr[$_ - 1] + $arr[$_ - 2]);
}

my @prime = ();
my $x = 0;
  sub prime {
    my $n = shift;
    my $n2 = shift;
    my $k = shift;

    for(my $j = $k; $j <= $n2; $j += 2){
      unless($n % $j){
        push @prime, $j;  
        $x++;
        return $j;
      }
    }
    push @prime, $n;
    return $n;
  }  

while($t--){
  my $n = int(<STDIN>);
  my $n2 = int(sqrt($n) + 1);
  $x = 0;
  @prime = ();

  if($n % 2){
    OUTER: 
    for(my $i=1; $i++; $i<=97){
      $x = 0;
      my $p = (( defined $prime[0]) ? $prime[0] : &prime($n, $n2, 3));      
    
      INNER:  
      while($p <= $arr[$i]){
        unless($arr[$i] % $p){
          print "$arr[$i] $p \n";
          last OUTER;
        }elsif($p < $n){
          $p = ((defined $prime[$x]) ? $prime[$x++] : &prime($n, $n2, $p+2));
        }else{
          last INNER;
        }
      }
    }
  }else{
    print "2 2 \n";
  }
}