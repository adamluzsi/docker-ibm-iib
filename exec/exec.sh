#!/bin/sh
test -z "$1" && exit 1

COMMAND="${2-/bin/bash}"
IMAGE_ID=$(docker images -q "$1" | head -n 1)
CONTAINER_ID=$(docker ps | awk '{ print($1) }' | tail -n 1)

docker exec \
	--tty \
	--interactive \
	--env LICENSE \
	--env DISPLAY="unix$DISPLAY" \
	"$CONTAINER_ID" "$COMMAND"
