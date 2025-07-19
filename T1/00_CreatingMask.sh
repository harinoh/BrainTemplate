#!/bin/bash

homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
cd $homedir

ImageMath 3 KOR152_mask.nii.gz Normalize KOR152.nii.gz
ThresholdImage 3 KOR152_mask.nii.gz KOR152_mask.nii.gz 0.1 1
