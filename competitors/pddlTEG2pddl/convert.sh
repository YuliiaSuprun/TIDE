#!/bin/sh

BINPATH=$(pwd) # competitors/pddlTEG2pddl
PDDL2EFFAX=$BINPATH/pddl2effax.sh
PL=swipl
TOPDDL=$BINPATH/topddl.pl
FF=~/FF-X/ff

if [ $# -ne 5 ]
then
  echo "Usage: `basename $0` <input-PDDL-domain-file> <input-PDDL-problem-file> <output-PDDL-domain-file> <output-PDDL-problem-file> <\"dp\" or \"cr\">"
  exit 1
fi


THIS_PID=$$
DOMAIN_FILE=$1
PROBLEM_FILE=$2
MODE=$5

OUTPUT_PDDL_DOMAIN=$3
OUTPUT_PDDL_PROBLEM=$4

# Ensure the tmp directory exists
mkdir -p $BINPATH/tmp

OUTPUT_PROLOG_DOMAIN=`mktemp $BINPATH/tmp/input-domain.XXXXXXX.pl`
OUTPUT_PROLOG_PROBLEM=`mktemp $BINPATH/tmp/input-problem.XXXXXXX.pl`
OUTPUT_DOMAIN=`mktemp $BINPATH/tmp/output-domain.XXXXXXX.pl`
OUTPUT_PROBLEM=`mktemp $BINPATH/tmp/output-problem.XXXXXXX.pl`

# Set time and memory constraints (15 minutes and 1GB)

#ulimit -S -v 1048576
#ulimit -S -t 900

echo $PDDL2EFFAX $DOMAIN_FILE $PROBLEM_FILE $OUTPUT_DOMAIN $OUTPUT_PROBLEM $OUTPUT_PROLOG_DOMAIN $OUTPUT_PROLOG_PROBLEM
$PDDL2EFFAX $DOMAIN_FILE $PROBLEM_FILE $OUTPUT_DOMAIN $OUTPUT_PROBLEM $OUTPUT_PROLOG_DOMAIN $OUTPUT_PROLOG_PROBLEM

echo $PL -s $TOPDDL -q --nosignals -t "topddl('','$OUTPUT_DOMAIN','$OUTPUT_PROBLEM','OUTPUT_PDDL_DOMAIN',$MODE)."
$PL -s $TOPDDL -q --nosignals -t "topddl('','$OUTPUT_DOMAIN','$OUTPUT_PROBLEM','$OUTPUT_PDDL_DOMAIN','$OUTPUT_PDDL_PROBLEM',$MODE)."

# Remove temporal files 

#rm -f $OUTPUT_PROLOG_DOMAIN
#rm -f $OUTPUT_PROLOG_PROBLEM
#rm -f $OUTPUT_DOMAIN
#rm -f $OUTPUT_PROBLEM

# EXECUTE FF
#FF_RESULT=~/pddlTEG2pddl/ff_result.txt
#$FF -o $OUTPUT_PDDL_DOMAIN -f $OUTPUT_PDDL_PROBLEM > $FF_RESULT

