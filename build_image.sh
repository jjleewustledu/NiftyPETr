#! /bin/bash

nvidia-docker build -t niftypetr-image -f ${HOME_DOCKER}/NiftyPETr/Dockerfile ${HOME_DOCKER}/NiftyPETr
