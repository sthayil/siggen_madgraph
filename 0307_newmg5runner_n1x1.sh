#!/bin/bash

#usage: source 0307_.~~~.sh mn1 mx1
echo "$1 $2 $3"

cp n1_x1.mg5 n1_x1_$1_$2.mg5
n1_x1=n1_x1_$1_$2.mg5

sed -i "s/-xxxx/-$1/g" $n1_x1
sed -i "s/-yyyy/-$2/g" $n1_x1
sed -i "s/1 xxxx/1 $1/g" $n1_x1
sed -i "s/1 yyyy/1 $2/g" $n1_x1

../bin/mg5_aMC n1_x1_$1_$2.mg5 

gunzip events_n1_x1-$1-$2/Events/run01/unweighed_events.lhe.gz

python 0306_checklhebranchingratio.py events_n1_x1-$1-$2/Events/run_01/unweighted_events.lhe
