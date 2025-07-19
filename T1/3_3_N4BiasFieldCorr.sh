#!/bin/bash

homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
wdir=$homedir/Raw_data

#for i in [IN]*
for i in $@

do
        if [ ! -e $wdir/$i/baseline/N4Bias/${i}_N4corr_ANTSbet.nii.gz ] ; then
	        mkdir $wdir/$i/baseline/N4Bias

                N4BiasFieldCorrection -d 3 -i $wdir/$i/baseline/ANTS_extract/${i}_BrainExtractionBrain.nii.gz \
			-x $i/baseline/ANTS_extract/${i}_BrainExtractionMask.nii.gz \
			-v 1 -o $wdir/$i/baseline/N4Bias/${i}_N4corr_ANTSbet.nii.gz
        else
                echo "Bias Field Correction completed in subject ${i}"
                continue
        fi
done
