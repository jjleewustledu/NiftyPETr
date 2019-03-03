#! /bin/bash
# from login node:  singularity pull docker://jjleewustledu/niftypetr-image:reconstruction
unset CONDA_DEFAULT_ENV
module load cuda-9.1
module unload cuda-7.5
nvidia-smi > nvidia-smi.log
module load singularity-20181030
singularity exec --bind $SINGULARITY_HOME/NiftyPET_tools:/NiftyPET_tools --bind $SINGULARITY_HOME/hardwareumaps:/hardwareumaps --bind $SINGULARITY_HOME:/SubjectsDir niftypetr-image_reconstruction.sif python /work/NiftyPETy/respet/recon/reconstruction.py -p /SubjectsDir/CCIR_00754/ses-E00853/HO_DT20190110111638.000000-Converted-NAC

