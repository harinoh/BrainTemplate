#!/bin/bash

t=4

homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1

## Checking for correlation between {t-1}th brain template and {t}th brain template
ImageMath 3 output PearsonCorrelation $dir/Affine_ANTS${t}/A1Image_$((t-1)).nii.gz $dir/Affine_ANTS${t}/Concat/A1Image_${t}.nii.gz

## Step 5 is repeated until the coefficient >= 0.9995
