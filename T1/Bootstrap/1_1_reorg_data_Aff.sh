#!/bin/bash

s=120
t=1
n=2

homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
wdir=$homedir/Bootstrap/S${s}/Trial_${t}

if [ ! -d $wdir/Affine_ANTS${n} ] ; then
    mkdir $wdir/Affine_ANTS${n}
else
    echo "Folder for Affine ${n} already created"
fi

cd $wdir

for i in [IN]*
do
	if [ ! -e $wdir/Affine_ANTS${n}/${i}_RigidWarped.nii.gz ] ; then
		cp $wdir/$i/${i}_RigidWarped.nii.gz $wdir/Affine_ANTS${n}/${i}_RigidWarped.nii.gz

	else
		echo "subject ${i} already copied to Affine_ANTS${n}"
		continue
	fi
done

## For 1st iteration of creating brain template
#	AverageImages 3 $wdir/Affine_ANTS${n}/A1Image_$((n-1)).nii.gz 0 $wdir/Affine_ANTS${n}/*RigidWarped.nii.gz
#	fslmaths Affine_ANTS1/A1Image_0.nii.gz -bin Affine_ANTS1/A1Image_0_mask.nii.gz

## second time onwards
	cp $wdir/Affine_ANTS$((n-1))/Warped_Only/AffineBTPtemplate.nii.gz $wdir/Affine_ANTS${n}/A1Image_$((n-1)).nii.gz
	ThresholdImage 3 $wdir/Affine_ANTS${n}/A1Image_$((n-1)).nii.gz $wdir/Affine_ANTS${n}/A1Image_$((n-1))_mask.nii.gz 0.1 inf
	ImageMath 3 $wdir/Affine_ANTS${n}/A1Image_$((n-1))_mask.nii.gz Normalize $wdir/Affine_ANTS${n}/A1Image_$((n-1))_mask.nii.gz
	fslmaths $wdir/Affine_ANTS${n}/A1Image_$((n-1)).nii.gz -mul $wdir/Affine_ANTS${n}/A1Image_$((n-1))_mask.nii.gz \
		$wdir/Affine_ANTS${n}/A1Image_$((n-1)).nii.gz

