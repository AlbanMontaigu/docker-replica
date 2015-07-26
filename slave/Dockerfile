# Base image
FROM debian:wheezy

# Set environment variables
ENV DEBIAN_FRONTEND="noninteractive" \
    REPLICA_DATA_DIR="/var/replica" \
    UNISON_DIR="/root/.unison"

# System base installation
RUN apt-get update \
    && apt-get install -y openssh-server unison \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && mkdir /var/run/sshd \
    && sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && echo 'root:ezr5kKj@2' | chpasswd \
    && mkdir -p $REPLICA_DATA_DIR \
    && chmod 777 $REPLICA_DATA_DIR

# Where unison store some internal data like status
VOLUME $UNISON_DIR

# Where replicate data is stored
VOLUME $REPLICA_DATA_DIR
WORKDIR $REPLICA_DATA_DIR

# Default sshd port
EXPOSE 22

# To enable live configuration
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Enable entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]

# Start open-ssh server in daemon mode
CMD ["/usr/sbin/sshd", "-D"]
