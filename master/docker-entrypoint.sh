#!/bin/sh

# Want to exit cleanly with subprocess
trap 'kill -TERM $PID; wait $PID; exit 0' TERM INT

# Want to have sync for ever...
while true; do

    # Log message for syncing start
    echo "[$(date)] Syncing start"

    # Now running sync !
    sshpass -p $REPLICA_SLAVE_PWD unison -batch -confirmbigdel=false $REPLICA_DATA_DIR ssh://root@$REPLICA_SLAVE_HOST/$REPLICA_DATA_DIR -sshargs "-p ${REPLICA_SLAVE_PORT}" &
    PID=$!
    wait $PID

    # Not sync every second !
    echo "[$(date)] Syncing end, now sleeping for $REPLICA_INTERVAL seconds"
    sleep $REPLICA_INTERVAL &
    PID=$!
    wait $PID

done
