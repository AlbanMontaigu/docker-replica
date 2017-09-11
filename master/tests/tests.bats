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
@test "Unison version is ${UNISON_VERSION} on replica master" {
	result="$(docker run --entrypoint=/bin/sh --rm ${DOCKER_APP_IMAGE_NAME} unison -version)"
	[[ "$result" == *"unison version ${UNISON_VERSION}"* ]]
}
