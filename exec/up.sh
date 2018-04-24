#!/bin/sh
test -z "$1" && exit 1

IMAGE_ID=$(docker images -q "$1" | head -n 1)

docker run \
	--tty \
	--net=host \
	--publish-all \
	--interactive \
	--device /dev/snd \
	--env LICENSE \
	--env XAUTH_LIST \
	--env DISPLAY="unix$DISPLAY" \
	--volume "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	--volume $HOME/.Xauthority:/root/.Xauthority \
	--volume $HOME/.Xauthority:/home/iibuser/.Xauthority \
	"$IMAGE_ID"
