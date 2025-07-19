#!/bin/bash

## creating brain template from individual nonlinear registration

t=4
homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
anal_dir=$homedir/ANTS${t}_Nonlinear

if [ ! -d ${anal_dir}/Warped_Only ] ; then
    mkdir ${anal_dir}/Warped_Only
else
    echo "Folder exist"
fi

cd $anal_dir

buildtemplateparallel.sh -d 3 -o Warped_Only/NonlinBTP -c 2 -j 40 \
	-z A2Image_$((t-1)).nii.gz \
	*NonlinearWarped.nii.gz *RigidWarped.nii.gz

