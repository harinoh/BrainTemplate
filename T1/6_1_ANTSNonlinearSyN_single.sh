# !/bin/bash

## Nonlinear registration (Individual registration)

t=4
homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
out_dir=$homedir/ANTS${t}_Nonlinear

#for i in [IN]*
for i in $@
do
	if [ ! -e ANTS${t}_Nonlinear/${i}_NonlinearWarped.nii.gz ] ; then
		
		ANTS 3 -x $out_dir/A2Image_$((t-1))_mask.nii.gz -m CC[$out_dir/A2Image_$((t-1)).nii.gz,$out_dir/${i}_RigidWarped.nii.gz,1,5] -T 2 \
                        -t SyN -r Gauss[3,0] \
			--number-of-affine-iterations 10000x10000x10000x10000 -i 100x100x100 -o $out_dir/${i}_Nonlinear  --use-Histogram-Matching 1
#			-m MI[$out_dir/A2Image_$((t-1)).nii.gz,$out_dir/${i}_RigidWarped.nii.gz,1] --MI-option 64x64000
		
		antsApplyTransforms -d 3 -e 0 -i $out_dir/${i}_RigidWarped.nii.gz -r $out_dir/A2Image_$((t-1)).nii.gz \
			-o $out_dir/${i}_NonlinearWarped.nii.gz -t $out_dir/${i}_NonlinearAffine.txt -t $out_dir/${i}_NonlinearWarp.nii.gz
		
	else
		echo "subject ${i} nonlinear registration completed"
		continue
        fi
done
