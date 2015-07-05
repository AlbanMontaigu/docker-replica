# Base image
FROM debian:wheezy

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Add specific user for replication
RUN groupadd replica && useradd -m -g replica -G users replica-slave

# System base installation
RUN apt-get update \
	 && apt-get install -y openssh-server \
	 && apt-get autoremove -y \
	 && apt-get autoclean

# System custom installation
RUN mkdir -p /var/run/sshd \
		&& sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin no\n AllowUsers replica-slave\n/' /etc/ssh/sshd_config \
		&& sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
		&& echo 'replica-slave:ezr5kKj@2' | chpasswd \
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
CMD ["/usr/sbin/sshd", "-D"]
