# !/bin/bash

homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
wdir=$homedir/Raw_data
mni_dir=/usr/local/fsl/data/standard

cd $wdir

for i in [IN]*
#for i in $@
do
	if [ ! -e $wdir/$i/baseline/ANTS_extract/${i}_BrainExtractionBrain.nii.gz ] ; then
		mkdir $wdir/$i/baseline/ANTS_extract
		antsBrainExtraction.sh -d 3 -a $wdir/$i/baseline/T1/*nii.gz -e $roi_dir/MNI152_nlin_sym_T1_1mm.nii -m $roi_dir/MNI152_nlin_sym_T1_1mm_mask.nii -o $wdir/$i/baseline/ANTS_extract/${i}_
	else
		echo "subject ${i} skull stripped"
		continue
	fi
done
