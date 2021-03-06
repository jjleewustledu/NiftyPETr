# reference: https://hub.docker.com/u/jjleewustledu
FROM jjleewustledu/niftypetd-image:nipet20191022

LABEL maintainer="John J. Lee <www.github.com/jjleewustledu>"

# setup volumes
ENV    PROJECTS_DIR=/ProjectsDir
ENV    SUBJECTS_DIR=/SubjectsDir
VOLUME $HARDWAREUMAPS
VOLUME $PROJECTS_DIR
VOLUME $SUBJECTS_DIR

# pip install:  anaconda packages will go to /opt/conda/lib/python2.7/site-packages
#RUN pip --no-cache-dir install --upgrade pixiedust

# install NiftyPETy, interfile
WORKDIR $HOME
COPY NiftyPETy $HOME/NiftyPETy
COPY interfile $HOME/interfile
RUN cd $HOME/NiftyPETy && \
    python setup.py install && \
    cd $HOME/interfile && \
    python setup.py install
# alternatively, install interfile and NiftyPETy manually;
# then exit container and issue:
# > nvidia-docker commit niftypetr-container jjleewustledu/niftypetr-image:reconstruction20191031

# run jupyter
#EXPOSE 7746
#WORKDIR $HOME
#ADD run_jupyter.sh $HOME/run_jupyter.sh
#RUN chmod +x $HOME/run_jupyter.sh
#CMD ["./run_jupyter.sh"]

# run echo_args.py
#WORKDIR /work
#COPY echo_args.py /work/echo_args.py
#ENTRYPOINT ["python", "/work/echo_args.py"]
#CMD []

# run bash
#WORKDIR $PROJECTS_DIR
#CMD ["/bin/bash"]

# localhost> nvidia-docker push jjleewustledu/niftypetr-image:reconstruction20191031
# chpc> singularity pull docker://jjleewustledu/niftypetr-image:reconstruction20191031

# run reconstruction.py; replace "-h" with:
# "-v", "false", 
# "-g", "0", 
# "-p", "/SubjectsDir/ses-dir/TRACER_DT1234.0000-Converted-NAC"
WORKDIR    $PROJECTS_DIR
ENTRYPOINT ["python", "/work/NiftyPETy/respet/recon/reconstruction.py"]
CMD        ["-h"]
