#!/bin/bash
## for those subject that requires manual extraction

homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
wdir=$homedir/Raw_data

#for i in [IN]*
for i in $@
        do
		if [ ! -e $wdir/$i/baseline/BET/${i}_bet_mask_final.nii.gz ] ; then
            fslmaths $wdir/$i/baseline/T1/${i}_raw.nii.gz -mul $wdir/$i/baseline/BET/${i}_bet_mask_final.nii.gz $wdir/$i/baseline/BET/${i}_bet_final.nii.gz
		else
            echo "Original BET mask is valid"
            continue
        fi
        done
