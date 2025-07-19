#!/bin/bash

## creating brain template from individual affine registration

t=4
homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
anal_dir=$homedir/Affine_ANTS${t}

if [ ! -d ${anal_dir}/Warped_Only ] ; then
    mkdir ${anal_dir}/Warped_Only
else
    echo "Folder exist"
fi

cd $anal_dir

buildtemplateparallel.sh -d 3 -o Warped_Only/AffineBTP -c 2 -j 40 \
	-s CC -z A1Image_$((t-1)).nii.gz \
	*RigidWarped.nii.gz *AffineWarped.nii.gz
