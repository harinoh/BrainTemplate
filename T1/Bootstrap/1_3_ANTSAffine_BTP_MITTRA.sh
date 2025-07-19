#!/bin/bash

s=120
t=1
n=2

homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
anal_dir=$homedir/Bootstrap/S${s}/Trial_${t}/Affine_ANTS${n}

if [ ! -d $anal_dir/Warped_Only ] ; then
    mkdir $anal_dir/Warped_Only
else
    echo "folder already exist"
fi

cd $anal_dir

buildtemplateparallel.sh -d 3 -o Warped_Only/AffineBTP -c 2 -j 40 \
        -z A1Image_$((n-1)).nii.gz \
        *AffineWarped.nii.gz *RigidWarped.nii.gz
