# Base image
FROM debian:wheezy

# Set environment variables
ENV DEBIAN_FRONTEND="noninteractive" \
    REPLICA_DATA_DIR="/var/replica" \
    REPLICA_SLAVE_HOST="replica-slave" \
    REPLICA_SLAVE_PORT="22" \
    REPLICA_SLAVE_PWD="ezr5kKj@2" \
    UNISON_DIR="/root/.unison" \
    UNISON_PRF="replica-master"

# System base installation
RUN apt-get update \
    && apt-get install -y ssh sshpass python-pyinotify unison  \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && echo 'root:qsdqsdseFFfj@33' | chpasswd \
    && mkdir -p --mode=777 $REPLICA_DATA_DIR \
    && mkdir -p --mode=777 $UNISON_DIR

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
