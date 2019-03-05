#! /bin/bash
DOCKER_HOME=/home2/jjlee/Docker
CONTAINER_NAME=$1
IMAGE_NAME=$2
CMD=$3

if [[ $# -eq 0 ]] ; then
    echo 'USAGE: docker rm some-jupyter-container'
    echo 'USAGE: run_container.sh some-jupyter-container [some-image] [CMD]'
    echo 'N.B.:  default some-image := `basename some-jupyter-container -container`-image:latest'
    exit 0
fi
if [[ $# -eq 1 ]] ; then
    IMAGE_NAME=`basename $1 -container`-image:latest
    CMD=' '
fi
if [[ $# -eq 2 ]] ; then
    CMD=' '
fi

#RECON_PREFIX=${DOCKER_HOME}/Cache/ses-E00853

CONTAINER="nvidia-docker run -it --name $CONTAINER_NAME --net=host -v ${DOCKER_HOME}/hardwareumaps/:/hardwareumaps -v ${DOCKER_HOME}/NiftyPET_tools/:/NiftyPET_tools -v /scratch/jjlee/Singularity:/SubjectsDir $IMAGE_NAME $CMD"
echo 'Starting container with commmand: '$CONTAINER
eval $CONTAINER
