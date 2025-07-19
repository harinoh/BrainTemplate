#!/bin/bash

homedir=/Volume/CCNC/harin_oh/2_braintemplate/BRL

cd $homedir

for i in N*
#for i in $@
do
    i_dir=$homedir/$i
	if [ ! -e  $i_dir/N4Bias/$i_dir_N4Bias.nii.gz ] ; then
		mkdir $i_dir/N4Bias

		antsAtroposN4.sh -d 3 -a $i_dir/ANTS_extract/$i_dir_BrainExtractionBrain.nii.gz \
			-x $i_dir/ANTS_extract/$i_dir_BrainExtractionMask.nii.gz \
			-c 4 -o $i_dir/N4Bias/$i_dir_N4Bias.nii.gz

#		N4BiasFieldCorrection -d 3 -i $i_dir/ANTS_extract/$i_dir_BrainExtractionBrain.nii.gz \
#			-x $i_dir/ANTS_extract/$i_dir_BrainExtractionMask.nii.gz \
#			-v 1 -o $i_dir/N4Bias/$i_dir_N4Bias.nii.gz
	else
		echo "subject $i_dir successfully bias corrected"
		continue
	fi
done
