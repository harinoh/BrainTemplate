#!/bin/bash

s=120
t=1
n=1

homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
wdir=$homedir/Bootstrap/S${s}/Trial_${t}

ImageMath 3 output PearsonCorrelation $wdir/Affine_ANTS${n}/A1Image_$((n-1)).nii.gz $wdir/Affine_ANTS${n}/Warped_Only/AffineBTPtemplate.nii.gz

