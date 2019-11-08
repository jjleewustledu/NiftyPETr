#! /bin/bash

nvidia-docker build -t jjleewustledu/niftypetr-image:reconstruction20191031 -f ${HOME_DOCKER}/NiftyPETr/Dockerfile ${HOME_DOCKER}/NiftyPETr
