# !/bin/bash

t=4
homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
in_dir=$homedir/Affine_ANTS${t}

if [ ! -d $in_dir/Concat ] ; then
    mkdir $in_dir/Concat
else
    echo "Folder already exist"
fi

out_dir=$in_dir/Concat

cd $homedir/Raw_data

for i in [IN]*
#for i in $@
do
	i_dir=$homedir/Raw_data/$i/baseline
    
    ## Individual concatenation of Affine + Rigid transformation
	if [ ! -e $out_dir/${i}_Affineupdate.nii.gz ] ; then
		antsApplyTransforms -d 3 -i $i_dir/Atropos/${i}_Segmentation0N4.nii.gz -r $in_dir/A1Image_$((t-1)).nii.gz \
			-o $out_dir/${i}_Affineupdate.nii.gz -t $i_dir/Rigid/${i}_RigidAffine.txt \
			-t $in_dir/${i}_AffineAffine.txt -t $in_dir/${i}_AffineWarp.nii.gz
    else
        echo "subject ${i} affineupdate file already exist"
	fi
    
    ## Individual concatenation to previous brain template image
	if [ -e $in_dir/Warped_Only/AffineBTP${i}_AffineWarpedWarp.nii.gz ] ; then
		antsApplyTransforms -d 3 -i $out_dir/${i}_Affineupdate.nii.gz -r $in_dir/A1Image_$((t-1)).nii.gz \
			-o $out_dir/${i}_defupdate.nii.gz -t $in_dir/Warped_Only/AffineBTP${i}_AffineWarpedAffine.txt \
                        -t $in_dir/Warped_Only/AffineBTP${i}_AffineWarpedWarp.nii.gz
	else
		echo "subject ${i} completed concatenation"
		continue
    fi
done

## Creating {t}th average brain template
AverageImages 3 $out_dir/A1Image_${t}.nii.gz 0 $out_dir/*_defupdate.nii.gz
ThresholdImage 3 $out_dir/A1Image_${t}.nii.gz $out_dir/A1Image_${t}_mask.nii.gz 0.1 inf
ImageMath 3 $out_dir/A1Image_${t}_mask.nii.gz Normalize $out_dir/A1Image_${t}_mask.nii.gz
fslmaths $out_dir/A1Image_${t}.nii.gz -mul $out_dir/A1Image_${t}_mask.nii.gz $out_dir/A1Image_${t}.nii.gz
