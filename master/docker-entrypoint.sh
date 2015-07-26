#!/bin/sh

# Configuration is in docker file
UNISON_PRF_PATH="${UNISON_DIR}/${UNISON_PRF_FILE}"

#
# Generate unison dir if necessary 
#
if [ -d "${UNISON_DIR}" ]; then
    mkdir -p --mode=777 "${UNISON_DIR}"
fi

#
# Generate unison configuration if necessary
#
# /!\ Be carefull, if you change any config value, this file must be deleted or replaced /!\
#
if [ -e "${UNISON_PRF_PATH}" ]; then

echo -e "
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
maxerrors = 10
retry = 10

# Want to sync when a file change (normally with python-pyinotify)
repeat = watch

" > $UNISON_PRF_PATH

fi

#
# Now starting sync in endless mode thanks to repeat = watch
#
exec sshpass -p $REPLICA_SLAVE_PWD unison "${UNISON_PRF}"
