#!/bin/bash

IMAGE_IDS=$(docker images -q -a ibm/iib | tail -n +2)

while read -r IMAGE_ID; do
	docker ps -a | grep -e "$IMAGE_ID" | awk '{print($1)}' | xargs docker rm

	docker rmi -f "$IMAGE_ID"
done <<<"$IMAGE_IDS"
