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
