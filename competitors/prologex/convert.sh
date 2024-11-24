#!/bin/sh

BINPATH=$(pwd) #. #/u/jabaier/research/landmarks_in_pddl/bin
PDDL2EFFAX=$BINPATH/pddl2effax.sh
PL=swipl
#PL=prolog #for apps0
TOPDDL=$BINPATH/topddl.pl
#FF=~/FF-v2.3/ff
FF=~/FF-X/ff
ACTION_MODE=$4

if [ $# -ne 4 ]
then
  echo "Usage: `basename $0` <PDDL-domain-file> <PDDL-problem-file> <\"dp\" or \"cr\"> <1 or 2>"
  exit 1
fi


THIS_PID=$$
DOMAIN_FILE=$1
PROBLEM_FILE=$2
MODE=$3

CURR_PWD=$PWD

#TMP_OUTPUT_DIR=`echo $DOMAIN_FILE | sed -e "s/[^/]*$//" | sed -e "s/\/$//" |sed -e "s/benchmarks/sat-tmp-output/"`

TMP_OUTPUT_DIR=$CURR_PWD/tmp

DF=`basename $DOMAIN_FILE`
PF=`basename $PROBLEM_FILE`

BASE_PROBLEM=${PF%.pddl}
BASE_DOMAIN=${DF%.pddl}

#OUTPUT_DOMAIN=dom-`hostname`-$THIS_PID
#OUTPUT_PROBLEM=prob-`hostname`-$THIS_PID



OUTPUT_DOMAIN=$BASE_DOMAIN-$BASE_PROBLEM
OUTPUT_PROBLEM=$BASE_PROBLEM


#OUTPUT_TEGS=teg-`hostname`-$THIS_PID

OUTPUT_PROLOG_DOMAIN=plpddldom-`hostname`-$THIS_PID.pl
OUTPUT_PROLOG_PROBLEM=plpddlprob-`hostname`-$THIS_PID.pl

mkdir -p $TMP_OUTPUT_DIR

# Set time and memory constraints (15 minutes and 1GB)

#ulimit -S -v 1048576
#ulimit -S -t 900

echo $PDDL2EFFAX $DOMAIN_FILE $PROBLEM_FILE $TMP_OUTPUT_DIR/$OUTPUT_DOMAIN.pl $TMP_OUTPUT_DIR/$OUTPUT_PROBLEM.pl $TMP_OUTPUT_DIR/$OUTPUT_PROLOG_DOMAIN $TMP_OUTPUT_DIR/$OUTPUT_PROLOG_PROBLEM $ACTION_MODE

$PDDL2EFFAX $DOMAIN_FILE $PROBLEM_FILE $TMP_OUTPUT_DIR/$OUTPUT_DOMAIN.pl $TMP_OUTPUT_DIR/$OUTPUT_PROBLEM.pl $TMP_OUTPUT_DIR/$OUTPUT_PROLOG_DOMAIN $TMP_OUTPUT_DIR/$OUTPUT_PROLOG_PROBLEM $ACTION_MODE

echo $PL -s $TOPDDL -q -t "topddl('$TMP_OUTPUT_DIR','$OUTPUT_DOMAIN','$OUTPUT_PROBLEM',$MODE)."

$PL -s $TOPDDL -q -t "topddl('$TMP_OUTPUT_DIR','$OUTPUT_DOMAIN','$OUTPUT_PROBLEM',$MODE)."

rm -f domain.pddl facts.pddl


#EXECUTE FF PLANNER

#NEW_PDDL_DOMAIN=$TMP_OUTPUT_DIR'/'$OUTPUT_DOMAIN'_'$OUTPUT_PROBLEM'_'$MODE'.pddl' 
#NEW_PDDL_PROBLEM=$TMP_OUTPUT_DIR'/'$OUTPUT_PROBLEM'_'$MODE'.pddl'
#FF_RESULT=$TMP_OUTPUT_DIR/ff_result.txt
#FF_PR_PLAN=$TMP_OUTPUT_DIR/ff_pr_plan.txt
#FF_TEG_PLAN=$TMP_OUTPUT_DIR/ff_teg_plan.txt

#echo $FF -o $NEW_PDDL_DOMAIN -f $NEW_PDDL_PROBLEM

#$FF -o $NEW_PDDL_DOMAIN -f $NEW_PDDL_PROBLEM | cat>$FF_RESULT

#grep '[^(spent|(ff:))]: ' $FF_RESULT | sed 's/step/    /g' | cat>$FF_PR_PLAN

#sed '/O_[(COPY)(WORLD)(GOAL)(SYNC)]/d' $FF_PR_PLAN | sed '/advancing to distance/d' >$FF_TEG_PLAN


