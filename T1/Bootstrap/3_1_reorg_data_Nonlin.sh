#!/bin/bash

s=60
t=1
n=5
a=5

homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
wdir=$homedir/Bootstrap/S${s}/Trial_${t}

if [ ! -d $wdir/ANTS${n}_Nonlinear ] ; then
    mkdir $wdir/ANTS${n}_Nonlinear
else
    echo "nonlinear folder already exist"
fi

cd $wdir

for i in [IN]*
do
	if [ ! -e $wdir/ANTS${n}_Nonlinear/${i}_RigidWarped.nii.gz ] ; then
		cp $wdir/$i/${i}_RigidWarped.nii.gz $wdir/ANTS${n}_Nonlinear/${i}_RigidWarped.nii.gz

	else
		echo "subject ${i} already copied to Affine_ANTS${n}"
		continue
	fi
done

## For first iteration of creating Nonlinear brain tempalte
#	cp $wdir/Affine_ANTS${a}/Warped_Only/AffineBTPtemplate.nii.gz $wdir/ANTS${n}_Nonlinear/A2Image_$((n-1)).nii.gz
 
## Second Time onwards
	cp $wdir/ANTS$((n-1))_Nonlinear/Warped_Only/NonlinBTPtemplate.nii.gz $wdir/ANTS${n}_Nonlinear/A2Image_$((n-1)).nii.gz
#	cp Affine_ANTS1/A1Image_0_mask.nii.gz ANTS${n}_Nonlinear/A2Image_0_mask.nii.gz
