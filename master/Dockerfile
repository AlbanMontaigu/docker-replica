# Base image
FROM debian:wheezy

# Set environment variables
ENV DEBIAN_FRONTEND="noninteractive" \
    REPLICA_DATA_DIR="/var/replica" \
    REPLICA_SLAVE_HOST="replica-slave" \
    REPLICA_SLAVE_PORT="22" \
    REPLICA_SLAVE_PWD="ezr5kKj@2" \
    UNISON_DIR="/root/.unison" \
    UNISON_PRF="replica-master" \
    UNISON_VERSION="2.48.3"

# System base installation
RUN apt-get update \
    && apt-get install -y ssh sshpass python-pyinotify ocaml build-essential exuberant-ctags curl \
    && echo 'root:qsdqsdseFFfj@33' | chpasswd \
    && mkdir -p --mode=777 $REPLICA_DATA_DIR \
    && mkdir -p --mode=777 $UNISON_DIR

# Building unison since wheezy has no recent version...
RUN cd /tmp \
    && curl -o unison.tgz -SL http://www.cis.upenn.edu/~bcpierce/unison/download/releases/stable/unison-$UNISON_VERSION.tar.gz \
    && mkdir -p --mode=777 unison \
    && tar -zxf unison.tgz --strip-components=1 -C unison \
    && cd unison \
    && make install UISTYLE=text NATIVE=true INSTALLDIR=/bin \
    && cd \
    && apt-get purge -y ocaml build-essential exuberant-ctags curl \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/*

# Where unison store some internal data like status
VOLUME $UNISON_DIR

# Where replicate data is stored
VOLUME $REPLICA_DATA_DIR
WORKDIR $REPLICA_DATA_DIR

# Build entrypoint to enable custom script
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Custom ssh for user
RUN mkdir -p ~/.ssh \
    && echo "Host *\n    StrictHostKeyChecking no" > ~/.ssh/config

# Enable entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]
