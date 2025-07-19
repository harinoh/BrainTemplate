# !/bin/bash

t=4
homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
in_dir=$homedir/ANTS${t}_Nonlinear

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
    ## Individual concatenation of Rigid, Nonlinear Affine, Warp images
	if [ ! -e $out_dir/${i}_defupdate.nii.gz ] ; then
		antsApplyTransforms -d 3 -i $i_dir/Atropos/${i}_Segmentation0N4.nii.gz -r $in_dir/A2Image_$((t-1)).nii.gz \
			-o $out_dir/${i}_Rigidupdate.nii.gz -t $i_dir/Rigid/${i}_RigidAffine.txt 

		antsApplyTransforms -d 3  -i $out_dir/${i}_Rigidupdate.nii.gz -r $in_dir/A2Image_$((t-1)).nii.gz \
			-o $out_dir/${i}_Affineupdate.nii.gz -t $in_dir/${i}_NonlinearAffine.txt  -t $in_dir/${i}_NonlinearWarp.nii.gz
		
		antsApplyTransforms -d 3 -i $out_dir/${i}_Affineupdate.nii.gz -r $in_dir/A2Image_$((t-1)).nii.gz \
			-o $out_dir/${i}_Nonlinupdate.nii.gz -t $in_dir/Warped_Only/NonlinBTP${i}_NonlinearWarpedAffine.txt \
			-t $in_dir/Warped_Only/NonlinBTP${i}_NonlinearWarpedWarp.nii.gz
	else

		echo "subject ${i} competed concatenation"
		continue
	fi
done

## Creating {t}th average brain template
AverageImages 3 $out_dir/A2Image_${t}.nii.gz 1 $out_dir/*_Nonlinupdate.nii.gz
ThresholdImage 3 $out_dir/A2Image_${t}.nii.gz $out_dir/A2Image_${t}_mask.nii.gz 0.1 inf
ImageMath 3 $out_dir/A2Image_${t}_mask.nii.gz Normalize $out_dir/A2Image_${t}_mask.nii.gz
fslmaths $out_dir/A2Image_${t}.nii.gz -mul $out_dir/A2Image_${t}_mask.nii.gz $out_dir/A2Image_${t}.nii.gz
