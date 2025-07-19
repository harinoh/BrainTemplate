#!/bin/bash

t=4

homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1

## Checking for correlation between {t-1}th brain template and {t}th brain template
ImageMath 3 output PearsonCorrelation $dir/ANTS${t}_Nonlinear/A2Image_$((t-1)).nii.gz $dir/ANTS${t}_Nonlinear/Concat/A2Image_${t}.nii.gz

## Step 6 is repeated until the coefficient >= 0.9995
