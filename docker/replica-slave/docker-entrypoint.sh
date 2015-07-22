#!/bin/sh
set -e

# If no configuration done, do it
if env | grep -q ^REPLICA-SLAVE-PWD=; then

    # Changing password with the specified one to not use default password
    echo 'root:$REPLICA-SLAVE-PWD' | chpasswd

fi

# Executing process as root PID
exec "$@"
