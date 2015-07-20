# Base image
FROM debian:wheezy

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND="noninteractive" REPLICA_DATA_DIR="/var/replica"

# Add specific user for replication
RUN groupadd replica && useradd -m -g replica -G users replica-slave

# System base installation
RUN apt-get update \
	&& apt-get install -y openssh-server unison \
	&& apt-get autoremove -y \
	&& apt-get autoclean \
	&& mkdir /var/run/sshd \
	&& sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin no\n AllowUsers replica-slave\n/' /etc/ssh/sshd_config \
	&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
	&& echo 'replica-slave:ezr5kKj@2' | chpasswd \
	&& mkdir -p $REPLICA_DATA_DIR \
	&& chmod 777 $REPLICA_DATA_DIR

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
