# !/bin/bash

homedir=/Volume/CCNC/harin_oh/2_braintemplate/BRL
mni_dir=/usr/local/fsl/data/standard

cd $homedir

for i in N*
#for i in $@
do
    i_dir=$homedir/$i
	if [ ! -e i_dir/ANTS_extract/${i}_BrainExtractionBrain.nii.gz ] ; then
		mkdir $i_dir/ANTS_extract
		antsBrainExtraction.sh -d 3 -a $i_dir/T1/*nii.gz -e $mni_dir/MNI152_T1_1mm.nii.gz -m $mni_dir/MNI152_T1_1mm_brain_mask.nii.gz -o $i_dir/ANTS_extract/${i}_
		
	else
		echo "subject ${i} skull stripped"
		continue
	fi
done
