# reference: https://hub.docker.com/u/jjleewustledu
FROM jjleewustledu/niftypetd-image:Reconstruction

LABEL maintainer="John J. Lee <www.github.com/jjleewustledu>"

# Matlab Compiler Runtime Python Library requires
RUN yum install -y libXt && \
    yum install -y compat-libgfortran-41 && \
    yum install -y tcsh

# open ports for Jupyter, SSH
EXPOSE 7745
EXPOSE 22

# setup filesystem
RUN mkdir ds
ENV HOME=/ds
ENV SHELL=/bin/bash
VOLUME /ds
WORKDIR /ds
ADD run_jupyter.sh /ds/run_jupyter.sh
RUN chmod +x /ds/run_jupyter.sh

# setup environment
ENV MCR_ROOT $HOME/MATLAB-Compiler/MATLAB_Runtime/v94
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:$MCR_ROOT/runtime/glnxa64:$MCR_ROOT/bin/glnxa64:$MCR_ROOT/sys/os/glnxa64:$MCR_ROOT/extern/bin/glnxa64:$MCR_ROOT/sys/opengl/lib/glnxa64
ENV XAPPLRESDIR $MCR_ROOT/v94/X11/app-defaults
ENV MATLAB_SHELL=$SHELL
ENV SUBJECTS_DIR $HOME
ENV RELEASE /ds/lin64-tools
ENV REFDIR /ds/atlas
ENV REFDIR1 $REFDIR
ENV FSLDIR /ds/fsl
ENV FS_FREESURFERENV_NO_OUTPUT=1
ENV FREESURFER_HOME=/ds/freesurfer
ENV PATH $RELEASE:$FSLDIR/bin:$FSLDIR/etc/matlab:$PATH
ENV HARDWAREUMAPS /ds/hardwareumaps
ENV CCIR_RAD_MEASUREMENTS_DIR $HOME/xlsx

# must install MCR_RUNTIME
# must mount:  atlas, PyConstructResolved/for_testing, freesurfer, fsl, hardwareumaps, HYGLY*, xlsx
#. $FREESURFER_HOME/SetUpFreeSurfer.sh
#. $FSLDIR/etc/fslconf/fsl.sh 

CMD ["./run_jupyter.sh"]
