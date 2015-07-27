#!/bin/sh
set -e

# Configuration is in docker file
UNISON_PRF_FILE="${UNISON_DIR}/${UNISON_PRF}.prf"

#
# Generate unison configuration if necessary
#
# /!\ Be carefull, if you change any config value, this file must be deleted or replaced /!\
#
echo "Checking if ${UNISON_PRF_FILE} is created..."
if [ -f "${UNISON_PRF_FILE}" ]; then

    # Nothing to do at all
    echo "${UNISON_PRF_FILE} already created !"
else

    # Generates file
    echo "Creating ${UNISON_PRF_FILE}..."
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

# Do not want cofirm in batch mode
confirmmerge = false
confirmbigdel = false

# Want to manage conflic in a safe way
copyonconflict = true
prefer = newer

# Want to retry if failure
maxerrors = 100
retry = 100

# Want to sync when a file change (normally with python-pyinotify)
repeat = watch

" > $UNISON_PRF_FILE
fi

#
# Now starting sync in endless mode thanks to repeat = watch
#
echo "Executing unison with ${UNISON_PRF} profile..."
exec sshpass -p $REPLICA_SLAVE_PWD unison "${UNISON_PRF}"
