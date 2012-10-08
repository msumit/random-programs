#/usr/local/bin/perl -w
#
#http://www.codeforces.com/problemset/problem/199/D
#
my ($n, $k) = split(/\s/, <STDIN>);
my @left = split(//, <STDIN>);
my @right = split(//, <STDIN>);

sub act {
  my ($w, $p, $c) = @_;
 
  if($p+$k > $n){
    print "YES";
    exit;
  }
  
  if($w == 0){  #on left wall
    $left[$p - 1] = 'Y';
    act(1, $p+$k, $c+1) if($right[$p+$k-1] eq '-');
    act(0, $p+1, $c+1) if($left[$p] eq '-');
    act(0, $p-1, $c+1) if($left[$p-2] eq '-' and $p > $c+2);
  }else{        #on right wall
    $right[$p - 1] = 'Y';
    act(0, $p+$k, $c+1) if($left[$p+$k-1] eq '-');
    act(1, $p+1, $c+1) if($right[$p] eq '-');
    act(1, $p-1, $c+1) if($right[$p-2] eq '-' and $p > $c+2);  
  }
    
}

&act(0, 1, 0);
print "NO";