#! /bin/bash

nvidia-docker build -t jjleewustledu/niftypetr-image:reconstruction_cuda10 -f ${HOME_DOCKER}/NiftyPETr/Dockerfile ${HOME_DOCKER}/NiftyPETr
