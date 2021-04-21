FROM cern/cc7-base

MAINTAINER Benjamin Wynne (bwynne@cern.ch)

# Install CVMFS and config file
RUN yum install -y https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest.noarch.rpm
RUN yum install -y cvmfs
COPY default.local /etc/cvmfs/default.local

# Install athena dependencies
RUN yum install -y gcc man-db file make mesa-libEGL.x86_64 mesa-libGL.x86_64 libuuid-devel.x86_64 freetype.x86_64 redhat-lsb-core-4.1-27.el7.centos.1.x86_64 libaio.x86_64 libaio-devel.x86_64 root-graf-asimage.x86_64
RUN ln -s /lib64/libEGL.so.1 /lib64/libEGL.so
RUN ln -s /lib64/libGL.so.1 /lib64/libGL.so

# Work around systemd problem to allow CVMFS within container
# From https://stackoverflow.com/questions/50393525/failed-to-get-d-bus-connection-operation-not-permitted
# Uses https://github.com/gdraheim/docker-systemctl-replacement
COPY systemctl.py /usr/bin/systemctl
RUN chmod a+x /usr/bin/systemctl

# Add atlasLocalSetup to .bashrc
RUN echo "export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase" >> ~/.bashrc
RUN echo "source \$ATLAS_LOCAL_ROOT_BASE/user/atlasLocalSetup.sh" >> ~/.bashrc

# Set how the container starts
COPY entry-point.sh /entry-point.sh
ENTRYPOINT ["/entry-point.sh"]
CMD [ "/bin/bash" ]

