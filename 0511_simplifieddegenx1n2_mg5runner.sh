#!/bin/bash

#usage: source 0424_.~~~.sh process(eg x1_n1) mn1 mx1 mn2
echo "$1 $2 $3 $4"

cp  run_simplifieddegenx1n2_3leptons.mg5 run_simplifieddegenx1n2_$2_$3_$4_3leptons.mg5
specmg5=run_simplifieddegenx1n2_$2_$3_$4_3leptons.mg5

sed -i "s/xxxx/$2/g"   $specmg5
sed -i "s/yyyy/$3/g"   $specmg5
sed -i "s/zzzz/$4/g"   $specmg5

../bin/mg5_aMC $specmg5

cp output_x1_n2_simplifieddegenx1n2_3leptons/Cards/param_card.dat output_x1_n2_simplifieddegenx1n2_3leptons/Cards/param_card_$2-$3-$4.dat
[ ! -d mg5files ] && mkdir mg5files
mv $specmg5 mg5files
gunzip output_x1_n2_simplifieddegenx1n2_3leptons/Events/$2-$3-$4/unweighted_events.lhe.gz
python 0306_checklhebranchingratio.py output_x1_n2_simplifieddegenx1n2_3leptons/Events/$2-$3-$4/unweighted_events.lhe
