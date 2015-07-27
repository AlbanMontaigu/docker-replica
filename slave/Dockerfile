# Base image
FROM debian:wheezy

# Set environment variables
ENV DEBIAN_FRONTEND="noninteractive" \
    REPLICA_DATA_DIR="/var/replica" \
    UNISON_DIR="/root/.unison" \
    UNISONLOCALHOSTNAME="replica-slave" \
    UNISON_VERSION="2.48.3"

# System base installation
RUN apt-get update \
    && apt-get install -y openssh-server ssh sshpass python-pyinotify ocaml build-essential exuberant-ctags curl \
    && apt-get autoremove -y \
    && apt-get autoclean \
    && mkdir /var/run/sshd \
    && sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && echo 'root:ezr5kKj@2' | chpasswd \
    && mkdir -p --mode=777 $REPLICA_DATA_DIR \
    && mkdir -p --mode=777 $UNISON_DIR

# Building unison since wheezy has no recent version...
RUN cd /tmp \
    && curl -o unison.tgz -SL http://www.cis.upenn.edu/~bcpierce/unison/download/releases/stable/unison-$UNISON_VERSION.tar.gz \
    && mkdir -p --mode=777 unison \
    && tar -zxf unison.tgz --strip-components=1 -C unison \
    && cd unison \
    && make UISTYLE=text NATIVE=true \
    && cp -f unison /bin \
    && cp -f fsmonitor.py /bin \
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

# Default sshd port
EXPOSE 22

# To enable live configuration
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Enable entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]

# Start open-ssh server in daemon mode
CMD ["/usr/sbin/sshd", "-D"]
