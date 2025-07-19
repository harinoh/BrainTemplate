#!/bin/bash

s=120
t=1
n=1

homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
wdir=$homedir/Bootstrap/S${s}/Trial_${t}

ImageMath 3 output PearsonCorrelation $wdir/ANTS${n}_Nonlinear/A2Image_$((n-1)).nii.gz $wdir/ANTS${n}_Nonlinear/Warped_Only/NonlinBTPtemplate.nii.gz

