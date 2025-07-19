#!/bin/bash

s=40
t=1
n=5

homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
wdir=$homedir/Bootstrap/S${s}/Trial_${t}
out_dir=$wdir/ANTS${n}_Nonlinear

#for i in [IN]*
for i in $@
do
        if [ ! -e ANTS${n}_Nonlinear/${i}_NonlinearWarped.nii.gz ] ; then

		ANTS 3 -x ${out_dir}/A2Image_$((n-1))_mask.nii.gz -m CC[${out_dir}/A2Image_$((n-1)).nii.gz,${out_dir}/${i}_RigidWarped.nii.gz,1,5] -T 2 \
                        -t SyN -r Gauss[3,0] -m MI[${out_dir}/A2Image_$((n-1)).nii.gz,${out_dir}/${i}_RigidWarped.nii.gz,1] --MI-option 64x64000 \
                        --number-of-affine-iterations 10000x10000x10000x10000 -i 100x100x100 -o ${out_dir}/${i}_Nonlinear  --use-Histogram-Matching 1

                antsApplyTransforms -d 3 -e 0 -i ${out_dir}/${i}_RigidWarped.nii.gz -r ${out_dir}/A2Image_$((n-1)).nii.gz \
                        -o ${out_dir}/${i}_NonlinearWarped.nii.gz -t ${out_dir}/${i}_NonlinearAffine.txt

        else
                echo "subject ${i} nonlinear registration completed"
                continue
        fi
done
