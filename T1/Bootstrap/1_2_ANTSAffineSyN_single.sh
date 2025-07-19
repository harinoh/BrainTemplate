#!/bin/bash

s=120
t=1
n=2

homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
wdir=$homedir/Bootstrap/S${s}/Trial_${t}
out_dir=$wdir/Affine_ANTS${n}

cd $wdir

for i in $@
do
        if [ ! -e $out_dir/${i}_AffineWarped.nii.gz ] ; then
		ANTS 3 -x $out_dir/A1Image_$((n-1))_mask.nii.gz -m CC[$out_dir/A1Image_$((n-1)).nii.gz,$out_dir/${i}_RigidWarped.nii.gz,1,5] -T 2 \
                        -t SyN -r Gauss[3,0] -m MI[$out_dir/A1Image_$((n-1)).nii.gz,$out_dir/${i}_RigidWarped.nii.gz,1] --MI-option 64x64000 \
                        --number-of-affine-iterations 10000x10000x10000x10000 -i 1x0x0 -o $out_dir/${i}_Affine  --use-Histogram-Matching 1

                antsApplyTransforms -d 3 -e 0 -i $out_dir/${i}_RigidWarped.nii.gz -r $out_dir/A1Image_$((n-1)).nii.gz \
                        -o $out_dir/${i}_AffineWarped.nii.gz -t $out_dir/${i}_AffineAffine.txt -t $out_dir/${i}_AffineWarp.nii.gz

	else
                echo "subject ${i} finished Affine"
                continue
        fi
done
