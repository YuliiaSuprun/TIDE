#!/bin/bash

ulimit -f 20480

THIS_PID=$$
DOMAIN_FILE=$1
PROBLEM_FILE=$2
MODE=dp

CURR_PWD=$PWD
DF=`basename $DOMAIN_FILE`
PF=`basename $PROBLEM_FILE`

BASE_PROBLEM=${PF%.pddl}
BASE_DOMAIN=${DF%.pddl}
OUTPUT_DOMAIN=$BASE_DOMAIN-$BASE_PROBLEM
OUTPUT_PROBLEM=$BASE_PROBLEM

echo "./convert.sh $1 $2 dp $5"

./convert.sh $1 $2 dp $5

cp ./tmp/$OUTPUT_DOMAIN'_'$OUTPUT_PROBLEM'_'$MODE.pddl $3
cp ./tmp/$OUTPUT_PROBLEM'_'$MODE.pddl $4

cd ../