#!/bin/sh
set -e

# Generate host keys if not present
# @see https://github.com/sickp/docker-alpine-sshd/blob/master/versions/7.5/rootfs/entrypoint.sh
ssh-keygen -A

# If no configuration done, do it
echo "[$(date)] Checking if pwd should be changed..."
if env | grep -q ^REPLICA-SLAVE-PWD=; then

    # Changing password with the specified one to not use default password
    echo 'root:$REPLICA-SLAVE-PWD' | chpasswd
    echo "[$(date)] Password changed !"
else
    echo "[$(date)] Default password used (see docker file) !"
fi

# Executing process as root PID
exec "$@"
