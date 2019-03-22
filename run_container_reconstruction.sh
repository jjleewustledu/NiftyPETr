#! /bin/bash
CONTAINER_NAME=$1
IMAGE_NAME=$2
CMD=$3

if [[ $# -eq 0 ]] ; then
    echo 'USAGE: docker rm some-container'
    echo 'USAGE: run_container.sh some-container [some-image]' \
	 '"-p" "/SubjectsDir/prj-folder/ses-folder/tracer-folder"'
    echo 'N.B.:  default some-image := jjleewustledu/`basename some-container -container`-image:reconstruction_cuda10_1'
    exit 0
fi
if [[ $# -eq 1 ]] ; then
    IMAGE_NAME=jjleewustledu/`basename $1 -container`-image:reconstruction_cuda10_1
    CMD=' '
fi
if [[ $# -eq 2 ]] ; then
    CMD=' '
fi

CONTAINER="nvidia-docker run -it --name $CONTAINER_NAME -v ${DOCKER_HOME}/hardwareumaps/:/hardwareumaps -v ${SINGULARITY_HOME}:/SubjectsDir $IMAGE_NAME $CMD"
echo 'Starting container with commmand: '$CONTAINER
eval $CONTAINER
