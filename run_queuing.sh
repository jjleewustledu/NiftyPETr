#! /bin/bash

pushd $SINGULARITY_HOME
for prj in CCIR_*
do
    pushd $prj
    for ses in ses-*
    do
	pushd $ses
	for tra in *_DT*-Converted-NAC
	do
	    pushd $tra
	    echo qsub -F "\""$prj $ses $tra"\"" $SINGULARITY_HOME/run_reconstruction.pbs
	    popd
	done
	popd
    done
    popd
done



popd
