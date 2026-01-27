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


DIR_FILE=$(dirname $5)

INTER_DOMAIN=$DIR_FILE/old_domain.pl
INTER_PROBLEM=$DIR_FILE/old_problem.pl
INTER_TRANS=$DIR_FILE/trans_states.pl

echo $PL -s pddl2effax.pl -q -t "pddl2effax('$DOMAIN_FILE','$PROBLEM_FILE','$INTER_DOMAIN','$INTER_PROBLEM')."
$PL -s pddl2effax.pl -q -t "pddl2effax('$DOMAIN_FILE','$PROBLEM_FILE','$INTER_DOMAIN','$INTER_PROBLEM')."

#Apply Alternating Automaton translation:

echo $PL -s alt_aut_translator.pl -q -t "time(effax2alt('$INTER_DOMAIN','$INTER_PROBLEM','$3','$4','$INTER_TRANS',$7))."
$PL -s alt_aut_translator.pl -q -t "time(effax2alt('$INTER_DOMAIN','$INTER_PROBLEM','$3','$4','$INTER_TRANS',$7))."

