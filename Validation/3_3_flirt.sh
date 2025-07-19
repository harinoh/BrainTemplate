#!/bin/bash

temp_name=KOR152
homedir=/Volume/CCNC/harin_oh/2_braintemplate/BRL

for i in $@
do
	sub_dir=$homedir/$i

	if [ ! -e $sub_dir/flirt2${temp_name}/${i}_flirt2${temp_name}.nii.gz ] ; then
		mkdir $sub_dir/flirt2${temp_name}
		flirt -in $sub_dir/N4Bias/${i}_N4Bias.nii.gz -ref $homedir/${temp_name}_brain.nii.gz \
			-out $sub_dir/flirt2${temp_name}/${i}_flirt2KOR152 -omat $sub_dir/flirt2${temp_name}/${i}_flirt2KOR152.mat -dof 12
	else
		echo "subject ${i} successfully registered using flirt"
		continue
	fi
done
