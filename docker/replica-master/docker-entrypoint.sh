#!/bin/sh

# Want to exit cleanly with subprocess
trap 'kill -TERM $PID; wait $PID; exit 0' TERM INT

# Want to have sync for ever...
while true; do

	# Now running sync !
	sshpass -p $REPLICA_SLAVE_PWD unison -batch -confirmbigdel=false $REPLICA_DATA_DIR ssh://replica-slave@$REPLICA_SLAVE_HOST/$REPLICA_DATA_DIR &
	PID=$!
	wait $PID

	# Not sync every second !
	sleep $REPLICA_INTERVAL &
	PID=$!
	wait $PID

done
