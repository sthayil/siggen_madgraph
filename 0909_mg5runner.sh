#!/bin/bash

#usage: source 0909_.~~~.sh process(eg x1_n1) mn1 mx1 mn2
echo "$1 $2 $3 $4"

cp $1.mg5 $1_$2_$3_$4.mg5
specmg5=$1_$2_$3_$4.mg5

sed -i "s/-xxxx/-$2/g"   $specmg5
sed -i "s/-yyyy/-$3/g"   $specmg5
sed -i "s/-zzzz/-$4/g"   $specmg5
sed -i "s/1 xxxx/1 $2/g" $specmg5
sed -i "s/1 yyyy/1 $3/g" $specmg5
sed -i "s/2 zzzz/2 $4/g" $specmg5

../bin/mg5_aMC $1_$2_$3_$4.mg5 

gunzip events_$1-$2-$3-$4/Events/run_01/unweighted_events.lhe.gz

python 0306_checklhebranchingratio.py events_$1-$2-$3-$4/Events/run_01/unweighted_events.lhe
