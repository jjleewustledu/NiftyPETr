#! /bin/bash

nvidia-docker build -t jjleewustledu/niftypetr-image:reconstruction_cuda10_1 -f ${HOME_DOCKER}/NiftyPETr/Dockerfile ${HOME_DOCKER}/NiftyPETr
