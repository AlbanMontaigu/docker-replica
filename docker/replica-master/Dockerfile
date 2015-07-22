# Base image
FROM debian:wheezy

# Set environment variables
ENV DEBIAN_FRONTEND="noninteractive" \
    REPLICA_DATA_DIR="/var/replica" \
    REPLICA_SLAVE_HOST="replica-slave" \
    REPLICA_SLAVE_PORT="22" \
    REPLICA_SLAVE_PWD="ezr5kKj@2" \
    REPLICA_INTERVAL="10"

# System base installation
RUN apt-get update \
    && apt-get install -y ssh sshpass unison \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && echo 'replica-master:qsdqsdseFFfj@33' | chpasswd \
    && mkdir -p $REPLICA_DATA_DIR \
    && chmod 777 $REPLICA_DATA_DIR

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
