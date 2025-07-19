# !/bin/bash

homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
mni_dir=/usr/local/fsl/data/standard

#for i in [IN]*
for i in $@
do 
	if [ ! -e $homedir/Raw_data/$i/baseline/Rigid/${i}_RigidWarped.nii.gz ] ; then
		
		mkdir $homedir/Raw_data/$i/baseline/Rigid
		i_dir=$homedir/Raw_data/$i/baseline
	
		ANTS 3 -x $mni_dir/MNI152_T1_1mm_brain_mask.nii.gz -m MI[$mni_dir/MNI152_T1_1mm_brain.nii.gz,$i_dir/Atropos/${i}_Segmentation0N4.nii.gz,1] \
			--MI-option 64x64000 --number-of-affine-iterations 10000x10000x10000x10000 --do-rigid true --use-Histogram-Matching 1 \
			-i 1x0x0 -o $i_dir/Rigid/${i}_Rigid

		antsApplyTransforms -d 3 -e 0 -i $i_dir/Atropos/${i}_Segmentation0N4.nii.gz -r $mni_dir/MNI152_T1_1mm_brain.nii.gz \
			-o $i_dir/Rigid/${i}_RigidWarped.nii.gz -t $i_dir/Rigid/${i}_RigidAffine.txt
	else
		echo "Subject ${i} already registered to MNI152 template"
		continue
	fi
done
