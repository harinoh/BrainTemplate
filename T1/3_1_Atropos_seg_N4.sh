 !/bin/bash

homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
raw_data=$homedir/Raw_data
mni_dir=/usr/local/fsl/data/standard

for i in $@
do
	i_dir=$raw_data/$i/baseline
    ## to create segmentation priors.
#	if [ ! -e $i_dir/Atropos/${i}_2MNI.nii.gz ] ; then
#		mkdir $i_dir/Atropos

#		flirt -in $i_dir/ANTS_extract/${i}_BrainExtractionBrain.nii.gz -ref $mni_dir/MNI152_T1_1mm_brain.nii.gz \
#			-out $i_dir/Atropos/${i}_2MNI.nii.gz -omat $i_dir/Atropos/${i}_2MNI.mat
#	else
#		echo "subject ${i} registered to MNI"
#	fi
    
#	if [ ! -e $raw_data/$i/Atropos/MNI_2${i}.mat ] ; then
#		convert_xfm -omat $i_dir/Atropos/MNI_2${i}.mat -inverse $i_dir/Atropos/${i}_2MNI.mat
		
#		flirt -in $homedir/avg152T1_gray.nii.gz -ref $i_dir/ANTS_extract/${i}_BrainExtractionBrain.nii.gz \
#			-applyxfm -init $i_dir/Atropos/MNI_2${i}.mat -out $i_dir/Atropos/${i}_priors_gm.nii.gz
#		flirt -in $homedir/avg152T1_white.nii.gz  -ref $i_dir/ANTS_extract/${i}_BrainExtractionBrain.nii.gz \
#			-applyxfm -init $i_dir/Atropos/MNI_2${i}.mat -out $i_dir/Atropos/${i}_priors_wm.nii.gz
#		flirt -in $homedir/avg152T1_csf.nii.gz -ref $i_dir/ANTS_extract/${i}_BrainExtractionBrain.nii.gz \
#			-applyxfm -init $i_dir/Atropos/MNI_2${i}.mat -out $i_dir/Atropos/${i}_priors_csf.nii.gz
#    else
#        echo "subject ${i} segmented priors already exist"
#    fi
    
#	if [ ! -e $raw_data/$i/Atropos/${i}_Segmentation.nii.gz ] ; then
		## perform segmentation and N4 Bias field correction
		antsAtroposN4.sh -d 3 -a $i_dir/ANTS_extract/${i}_BrainExtractionBrain.nii.gz -x $i_dir/ANTS_extract/${i}_BrainExtractionMask.nii.gz \
			-c 3 -o $i_dir/Atropos/${i}_
#			-p $i_dir/Atropos/${i}_priors_gm.nii.gz,$i_dir/Atropos/${i}_priors_wm.nii.gz,$i_dir/Atropos/${i}_priors_csf.nii.gz

	else
		echo "subject ${i} T1 image already segmented"
		continue
	fi
done
