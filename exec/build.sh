#!/bin/sh

test -z "$IIB_VERSION" && exit 1

isDockerHasImage() {
	test "$(docker images -q "$1" 2>/dev/null)" != ""
}

dockerBuildImage() {
	IMAGE_NAME="$1"
	IMAGE_VERSION="$2"
	FOLDER_NAME="$3"

	if isDockerHasImage "$IMAGE_NAME"; then
		return 0
	fi

	docker build \
		-t "$IMAGE_NAME" \
		--build-arg PRODUCT_VERSION="$IMAGE_VERSION" \
		"$WORKING_DIR/$FOLDER_NAME"

	docker tag "$IMAGE_NAME" "$IMAGE_NAME:$IMAGE_VERSION"
}

dockerBuildImage "ibm/base" "latest" base
dockerBuildImage "ibm/iib" "$IIB_VERSION" iib
