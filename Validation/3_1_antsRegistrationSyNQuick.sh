#!/bin/bash

temp_name=KOR152
homedir=/Volume/CCNC/harin_oh/2_braintemplate/BRL

cd $homedir

for i in N*
#for i in $@
do
    i_dir=$homedir/$i
	if [ ! -e $i_dir/Reg2${temp_name}/$i_dir_norm2${temp_name}.nii.gz ] ; then
		mkdir $i_dir/Reg2${temp_name}
		antsRegistrationSyNQuick.sh -d 3 -f $i_dir/${temp_name}_brain.nii.gz -m $i_dir/N4Bias/$i_dir_N4Bias.nii.gz \
			-o $i_dir/Reg2${temp_name}/${i}_norm2${temp_name} -n 5
	else
		echo "subject ${i} successfuly normalized to ${temp_name}"
		continue
	fi
done
