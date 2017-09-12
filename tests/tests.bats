#!/usr/bin/env bats

# =======================================================================
#
# Testing the project
#
# @see https://github.com/sstephenson/bats
# @see https://blog.engineyard.com/2014/bats-test-command-line-tools
#
# =======================================================================

# Test unison version on replica master
@test "Unison version is ${UNISON_VERSION_MASTER} on replica master" {
	result="$(docker run --entrypoint=/bin/sh --rm ${DOCKER_APP_IMAGE_NAME_MASTER} -c 'unison -version')"
	[[ "$result" == *"unison version ${UNISON_VERSION_MASTER}"* ]]
}

# Test unison version on replica slave
@test "Unison version is ${UNISON_VERSION_SLAVE} on replica slave" {
	result="$(docker run --entrypoint=/bin/sh --rm ${DOCKER_APP_IMAGE_NAME_SLAVE} -c 'unison -version')"
	[[ "$result" == *"unison version ${UNISON_VERSION_SLAVE}"* ]]
}

#  Test file replication
@test "File replication is OK" {
    docker network create replica-network
    docker run -d --rm --network=replica-network --name replica-slave ${DOCKER_APP_IMAGE_NAME_SLAVE}
    docker run -d --rm --network=replica-network -e REPLICA_SLAVE_HOST="replica-slave" -e REPLICA_SLAVE_PORT="22" --name replica-master ${DOCKER_APP_IMAGE_NAME_MASTER}
    docker exec replica-slave /bin/sh -c 'echo TEST_TEXT > TEST_FILE'
    result="$(docker exec replica-master /bin/sh -c 'cat TEST_FILE')"
    docker stop replica-master
    docker stop replica-slave
    docker network rm replica-network
    [[ "$result" == "TEST_TEXT" ]]
}
