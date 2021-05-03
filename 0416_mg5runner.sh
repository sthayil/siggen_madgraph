#!/bin/bash

#usage: source 0909_.~~~.sh process(eg x1_n1) mn1 mx1 mn2
echo "$1 $2 $3 $4"

cp  run_$1_3leptons.mg5 run_$1_$2_$3_$4_3leptons.mg5
specmg5=run_$1_$2_$3_$4_3leptons.mg5

sed -i "s/xxxx/$2/g"   $specmg5
sed -i "s/yyyy/$3/g"   $specmg5
sed -i "s/zzzz/$4/g"   $specmg5

../bin/mg5_aMC run_$1_$2_$3_$4_3leptons.mg5

cp output_$1_3leptons/Cards/param_card.dat output_$1_3leptons/Cards/param_card_$2-$3-$4.dat
[ ! -d mg5files ] && mkdir mg5files
mv run_$1_$2_$3_$4_3leptons.mg5 mg5files
gunzip output_$1_3leptons/Events/$2-$3-$4/unweighted_events.lhe.gz
python 0306_checklhebranchingratio.py output_$1_3leptons/Events/$2-$3-$4/unweighted_events.lhe
