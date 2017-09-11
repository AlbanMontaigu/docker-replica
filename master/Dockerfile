
# =======================================================================
#
# Replica master
#
# =======================================================================

# Base image
FROM alpine:3.6

# Set environment variables
ENV REPLICA_DATA_DIR="/var/replica" \
    REPLICA_SLAVE_HOST="replica-slave" \
    REPLICA_SLAVE_PORT="22" \
    REPLICA_SLAVE_PWD="ezr5kKj@2" \
    UNISON_DIR="/root/.unison" \
    UNISON_PRF="replica-master" \
    UNISONLOCALHOSTNAME="replica-master" \
    UNISON_VERSION="2.48.4-r3"

# System & unison install / configuration
RUN apk --no-cache add openssh sshpass py-inotify ocaml  curl \
    && apk --no-cache add unison=$UNISON_VERSION \
    && rm -rf /var/cache/apk/* \
    && echo 'root:qsdqsdseFFfj@33' | chpasswd \
    && mkdir -p --mode=777 $REPLICA_DATA_DIR \
    && mkdir -p --mode=777 $UNISON_DIR \
    && mkdir -p ~/.ssh \
    && echo "Host *\n    StrictHostKeyChecking no" > ~/.ssh/config

# Where unison store some internal data like status
VOLUME $UNISON_DIR

# Where replicate data is stored
VOLUME $REPLICA_DATA_DIR
WORKDIR $REPLICA_DATA_DIR

# Build entrypoint to enable custom script
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Enable entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]
