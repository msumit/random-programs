#/usr/local/bin/perl -w
#
# Given a paragraph of text, write a program to find the first shortest sub-segment that contains each of the given k words at least once. A segment is said to be shorter than other if it contains less number of words.
# Ignore characters other than [a-z][A-Z] in the text. Comparison between the strings should be case-insensitive. 
# If no sub-segment is found then the program should output “NO SUBSEGMENT FOUND”.
#  
# Input format :
# First line of the input contains the text.
# Next line contains k , the number of  words given to be searched.
# Each of the next k lines contains a word.
#  
# Output format :
# Print first shortest sub-segment that contains given k words , ignore special characters, numbers.If no sub-segment is found it should return “NO SUBSEGMENT FOUND”
#  
# Sample Input :
# This is a test. This is a programming test. This is a programming test in any language.
# 4
# this
# a
# test
# programming
#  
# Sample Output :
# a programming test This
#  
# Explanation :
# In this test case segment "a programming test. This" contains given four words. You have to print without special characters, numbers so output is "a programming test This".  Another segment "This is a programming test." also contains given  four words but have more number of words. 
#  
# Constraint :
# Total number of character in a paragraph will not be more than 200,000.
# 0 < k <= no. of words in paragraph.
# 0 < Each word length < 15
# Time Limit : 16sec
#
# Read input from STDIN. Print output to STDOUT

my $str = <STDIN>;
my $k = int(<STDIN>);
my @arr;
my $temp;

for(1..$k){
  $temp = <STDIN>;
  chomp($temp);
  push @arr, $temp;
}

$str =~ s/[^a-zA-Z\s]//g;
$str .= " ";    
my $l = length $str;    
  
my ($start, $end1, $end2, $i, $flag, $s, $w) = (0, 0, 0, 0, 0, '', '');

for(1..$k){
  $end1 = index $str, " ", ++$end1;
}

OUTER:    
for($i = $k; ($end2-$start) <= $l; $i++){
  $start = 0;
  $end2 = $end1;  
  $end1 = index $str, " ", ++$end1;
    
  while($end2 < $l){
    $flag = 1;  
    $s = substr $str, $start, $end2-$start; 
    foreach $w (@arr){
      last unless ($flag);
      $flag = 0 if ($s !~ /\b$w\b/i); 
    } 
    if($flag){
      print $s;
      last OUTER;
    }      
    $start = index $str, " ", ++$start;
    $end2 = index $str, " ", ++$end2;  
    $end2 = $l if($end2 == -1);  
  }
}    
print "NO SUBSEGMENT FOUND" unless ($flag);