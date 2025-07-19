# !/bin/bash

a=1
t=S100_t3

homedir=/Volume/CCNC/harin_oh/2_braintemplate/BRL

if [ ! -d $homedir/Jacob/Reg2${t} ] ; then
    mkdir $homedir/Jacob/Reg2${t}
else
    echo "folder already created"
fi
out_dir=$homedir/Jacob/Reg2${t}

cd $homedir

for i in N*
do
	i_dir=$homedir/$i/Reg2${t}

	if [ ! -e $out_dir/Sub${a}_norm2${t}_logJacob.nii.gz ] ; then
		CreateJacobianDeterminantImage 3 $i_dir/*1Warp.nii.gz $out_dir/Sub${a}_norm2${t}_logJacob.nii.gz 1 0
		echo "Subject ${i} Jacobian calculated and renamed to sub${a}"
		a=$((a+1))

	else
		echo "subject ${i} sucessfully created to sub${a}"
		a=$((a+1))
		continue
	fi
done
