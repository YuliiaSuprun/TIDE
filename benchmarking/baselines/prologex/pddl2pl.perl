#!/usr/bin/perl

if ($#ARGV != 2) {
    die "$#ARGV: Usage pddl2pl <pddl-input-file> <prolog-output-file> <predicate-name>\n";
}

open(INPUT,$ARGV[0]) or die "Couldn't open input file $ARGV[1]";
open(OUTPUT,"> $ARGV[1]") or die "Couldn't open output file $ARGV[1]";

print OUTPUT "$ARGV[2]("; 

$buf="";

while ($line=<INPUT>) {
    chomp $line;
    $line=~s/;.*$//g;  # remove comments
    $buf.=" ".$line;
}

$buf=~ tr/A-Z/a-z/; # to lowercase
$buf=~s/\?/ \?/g;  # replace "?" by " ?" to avoid problems with some domains
$buf=~s/\(/\[/g;  # replace ( by [
$buf=~s/\)/\]/g;  # replace ) by ]
$buf=~s/\]\[/\] \[/g; # replace ][ by ] [
$buf=~s/\s+/ /g;   # replace multiple spaces by single space
$buf=~s/\s$//g;    # remove spaces before newline
$buf=~s/\s+\]/]/g;  # remove spaces before "]"
$buf=~s/\[\s+/[/g;  # remove spaces after "["
$buf=~s/([A-Z0-9a-z_:\?\-])\[/\1 [/g; 
$buf=~s/\s+/,/g;   # replace spaces by comas
$buf=~s/(\?\W)/'\1'/g; # quote variables
$buf=~s/([A-Z0-9a-z_:\?\-]+)/'\1'/g; # quote strings that would be prolog variables
$buf=~s/=/'='/g; # quote equals
# $buf=~s/\-/'-'/g; # quote dash


$buf=~s/^,+\[/[/g; # remove leading comas
print OUTPUT $buf."\n";

print OUTPUT ").";
