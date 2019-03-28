#! /bin/bash

nvidia-docker build -t jjleewustledu/niftypetr-image:reconstruction -f ${HOME_DOCKER}/NiftyPETr/Dockerfile ${HOME_DOCKER}/NiftyPETr
