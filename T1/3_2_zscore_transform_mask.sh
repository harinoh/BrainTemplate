# !/bin/bash

## Creating zscore transform maks of gw + wm

homedir=/Volume/CCNC/harin_oh/2_braintemplate/T1
wdir=$homedir/Raw_data

for i in $@
do
	i_dir=$wdir/$i/baseline
	if [ ! -e $i_dir/Atropos/${i}_SegmentationPosteriors3_mask.nii.gz ] ; then
        # gm
		ThresholdImage 3 $i_dir/Atropos/${i}_SegmentationPosteriors2.nii.gz $i_dir/Atropos/${i}_SegmentationPosteriors2_mask.nii.gz 0.3 inf
		ImageMath 3 $i_dir/Atropos/${i}_SegmentationPosteriors2_mask.nii.gz Normalize $i_dir/Atropos/${i}_SegmentationPosteriors2_mask.nii.gz
        
        # wm
		ThresholdImage 3 $i_dir/Atropos/${i}_SegmentationPosteriors3.nii.gz $i_dir/Atropos/${i}_SegmentationPosteriors3_mask.nii.gz 0.1 inf
		ImageMath 3 $i_dir/Atropos/${i}_SegmentationPosteriors3_mask.nii.gz Normalize $i_dir/Atropos/${i}_SegmentationPosteriors3_mask.nii.gz
	else
		echo "subject ${i} mask already exist"
	fi
    
	if [ ! -e $i_dir/Atropos/${i}_SegmentationPosteriors_gmwm_mask.nii.gz ] ; then
		ImageMath 3 $i_dir/Atropos/${i}_SegmentationPosteriors_gmwm_mask.nii.gz + $i_dir/Atropos/${i}_SegmentationPosteriors2_mask.nii.gz \
			$i_dir/Atropos/${i}_SegmentationPosteriors3_mask.nii.gz
		fslmaths $i_dir/Atropos/${i}_SegmentationPosteriors_gmwm_mask.nii.gz -bin $i_dir/Atropos/${i}_SegmentationPosteriors_gmwm_mask.nii.gz
	else
		echo "subject ${i}'s gmwm file already exist"
		continue
	fi
done
