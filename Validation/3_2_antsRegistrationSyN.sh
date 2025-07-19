#1/bin/bash

temp_name=KOR152
homedir=/Volume/CCNC/harin_oh/2_braintemplate/BRL

for i in $@
do
    i_dir=$homedir/$i
	if [ ! -d $i_dir/Reg2${temp_name} ] ; then
		mkdir $i_dir/Reg2${temp_name}
		antsRegistrationSyN.sh -d 3 -t s -f $homedir/KOR152_brain.nii.gz -m $i_dir/N4Bias/${i}_N4Bias.nii.gz \
			-i $i_dir/flirt2${temp_name}/${i}_flirt2${temp_name}.nii.gz -x $i_dir/${temp_name}_brain_mask.nii.gz -j 1 \
			-o $i_dir/Reg2${temp_name}/${i}_norm2${temp_name}

	else
		echo "subject ${i} registered to ${temp_name} template"
		continue
	fi
done
