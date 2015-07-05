# Base image
FROM debian:wheezy

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Add specific user for replication
RUN groupadd -r replica && useradd -r -g replica replica-slave

# System base installation
RUN apt-get update \
	 && apt-get install -y openssh-server --no-install-recommends \
	 && rm -rf /var/lib/apt/lists/*

# System custom installation
RUN mkdir -p /var/run/sshd \
		&& sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin no\n AllowUsers replica-slave\n/' /etc/ssh/sshd_config \
		&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
		&& 'replica-slave:ezr5kKj@2' | chpasswd \
		&& mkdir -p /var/replica-data \
		&& chmod 777 /var/replica-data

# Where replicate data is stored
VOLUME /var/replica-data

# To enable custom live configuration
COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# Default sshd port
EXPOSE 22

# Start open-ssh server in daemon mode
CMD ["sshd", "-D"]
