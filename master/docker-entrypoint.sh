#!/bin/sh

# Want to exit cleanly with subprocess
trap 'kill -TERM $PID; wait $PID; exit 0' TERM INT

# Configuration
UNISON_PRF_FILE="${UNISON_DIR}/${UNISON_PRF}.prf"
SYNC_PATHS_FILE="${REPLICA_DATA_DIR}/SYNC_PATHS"

# Generate host keys if not present
# @see https://github.com/sickp/docker-alpine-sshd/blob/master/versions/7.5/rootfs/entrypoint.sh
ssh-keygen -A

#
# Generate unison configuration if necessary
#
# /!\ Be careful, if you change any config value, this file must be deleted or replaced /!\
#
echo "[$(date)] Checking if ${UNISON_PRF_FILE} is created..."
if [ -f "${UNISON_PRF_FILE}" ]; then

    # Nothing to do at all
    echo "[$(date)] ${UNISON_PRF_FILE} already created !"
else

    # PRF file creation
    echo "[$(date)] Creating ${UNISON_PRF_FILE}..."
    echo "
# Batch mode
batch = true
auto = true

# No backup in addition to sync...
backups = false

# Source folder to sync
root = ${REPLICA_DATA_DIR}

# Destination (and distant) folder to sync
root = ssh://root@${REPLICA_SLAVE_HOST}/${REPLICA_DATA_DIR}
sshargs = -p ${REPLICA_SLAVE_PORT}
" > $UNISON_PRF_FILE

    # Integrate additional path if declared
    if [ -f "${SYNC_PATHS_FILE}" ]; then
        cat "${SYNC_PATHS_FILE}" >> $UNISON_PRF_FILE
    fi

    # End of the prf file
    echo "

# Do not sync configuration file
ignore = Name SYNC_PATHS

# Logs but not too much...
log = true
logfile = ${UNISON_DIR}/unison.log
silent = true

# Sync date and keep recent files
times = true
force = newer

# Want to keep owner and group
owner = true
group = true

# Do not want confirm in batch mode
confirmmerge = false
confirmbigdel = false

# Want to manage conflict in a safe way
copyonconflict = false
prefer = newer

# Want to retry if failure
maxerrors = 100
retry = 100

# Want to sync when a file change (normally with python-pyinotify)
repeat = watch

" >> $UNISON_PRF_FILE
fi

#
# Want to have sync for ever even if connection issue
#
while true; do

    # Now starting sync in endless mode thanks to repeat = watch
    echo "[$(date)] Executing unison with ${UNISON_PRF} profile..."
    sshpass -p $REPLICA_SLAVE_PWD unison "${UNISON_PRF}" &
    PID=$!
    wait $PID

    # Wait before retry !
    echo "[$(date)] Oops unison process end, now sleeping for 10 seconds before retry"
    sleep 10 &
    PID=$!
    wait $PID

done
