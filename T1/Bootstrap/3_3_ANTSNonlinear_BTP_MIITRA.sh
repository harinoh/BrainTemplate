#!/bin/bash

s=20
t=2
n=5

homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
wdir=$homedir/Bootstrap/S${s}/Trial_${t}
anal_dir=$wdir/ANTS${n}_Nonlinear

if [ ! -d $anal_dir/Warped_Only ] ; then
mkdir $anal_dir/Warped_Only

cd $anal_dir

buildtemplateparallel.sh -d 3 -o Warped_Only/NonlinBTP -c 2 -j 40 \
        -z A2Image_$((n-1)).nii.gz \
        *NonlinearWarped.nii.gz *RigidWarped.nii.gz
