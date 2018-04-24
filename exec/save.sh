#!/bin/sh

test -z "$WORKING_DIR" && exit 1

isDockerHasImage() {
	test $(docker images -q "$1" 2>/dev/null) != ""
}

DIST_PATH="$WORKING_DIR/dist"

if [ ! -d $DIST_PATH ]; then
	mkdir $DIST_PATH
fi

if isDockerHasImage ibm/iib; then
	docker save ibm/iib -o "$DIST_PATH/iib.image"
fi

if isDockerHasImage ibm/mq; then
	docker save ibm/iib -o "$DIST_PATH/mq.image"
fi
