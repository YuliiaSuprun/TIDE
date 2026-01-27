#!/bin/sh


#if ($#ARGV != 3) {
#    die "$#ARGV: Usage pddl2eff <pddl-domain-file> <pddl-problem-file> <output-domain-file> <output-problem-file>\n";
#}

DOMAIN_FILE=$5
PROBLEM_FILE=$6
PL=swipl

/usr/bin/perl pddl2pl.perl $1 $5 pddl_domain
/usr/bin/perl pddl2pl.perl $2 $6 pddl_problem

#echo "pl -s pddl2effax.pl -t \"pddl2effax('$DOMAIN_FILE','$PROBLEM_FILE','$3','$4').\""

echo $PL -s pddl2effax.pl -q -t "pddl2effax('$DOMAIN_FILE','$PROBLEM_FILE','$3','$4')."
$PL -s pddl2effax.pl -q -t "pddl2effax('$DOMAIN_FILE','$PROBLEM_FILE','$3','$4')."
