#!/bin/bash

homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
wdir=$homedir/Raw_data

cd $wdir

for i in [IN]*
#for i in $@
do
	if [ ! -e $wdir/$i/baseline/BET/*bet.nii.gz ] ; then
		mkdir $i/baseline/BET
		
		bet $i/baseline/T1/2*gz $i/baseline/BET/${i}_bet.nii.gz -f 0.35 -m -c 136 143 103
	else
		echo "BET file exist"
		continue
	fi
done
