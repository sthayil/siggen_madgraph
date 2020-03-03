#!/bin/bash

#usage: source 0303_.~~~.sh mn1 mx1 mn2
echo "$1 $2 $3"

n1_n1=n1_n1.mg5
n1_x1=n1_x1.mg5
x1_x1=x1_x1.mg5
x1_n2=x1_n2.mg5
n1_n2=n1_n2.mg5
n2_n2=n2_n2.mg5

sed -i "s/-xxxx/-$1/g" $n1_n1 $n1_x1 $x1_x1 $x1_n2 $n1_n2 $n2_n2
sed -i "s/-yyyy/-$2/g" $n1_n1 $n1_x1 $x1_x1 $x1_n2 $n1_n2 $n2_n2
sed -i "s/-zzzz/-$3/g" $n1_n1 $n1_x1 $x1_x1 $x1_n2 $n1_n2 $n2_n2
sed -i "s/1 xxxx/1 $1/g" $n1_n1 $n1_x1 $x1_x1 $x1_n2 $n1_n2 $n2_n2
sed -i "s/1 yyyy/1 $2/g" $n1_n1 $n1_x1 $x1_x1 $x1_n2 $n1_n2 $n2_n2
sed -i "s/2 zzzz/2 $3/g" $n1_n1 $n1_x1 $x1_x1 $x1_n2 $n1_n2 $n2_n2

../bin/mg5_aMC n1_x1.mg5 

cat $n1_x1

sed -i "s/-$1/-xxxx/g" $n1_n1 $n1_x1 $x1_x1 $x1_n2 $n1_n2 $n2_n2
sed -i "s/-$2/-yyyy/g" $n1_n1 $n1_x1 $x1_x1 $x1_n2 $n1_n2 $n2_n2
sed -i "s/-$3/-zzzz/g" $n1_n1 $n1_x1 $x1_x1 $x1_n2 $n1_n2 $n2_n2
sed -i "s/1 $1/1 xxxx/g" $n1_n1 $n1_x1 $x1_x1 $x1_n2 $n1_n2 $n2_n2
sed -i "s/1 $2/1 yyyy/g" $n1_n1 $n1_x1 $x1_x1 $x1_n2 $n1_n2 $n2_n2
sed -i "s/2 $3/2 zzzz/g" $n1_n1 $n1_x1 $x1_x1 $x1_n2 $n1_n2 $n2_n2

cat $n1_x1
