#!/bin/bash

if [ ! -z "$XAUTH_LIST" ]; then

	while read -r line; do
		xauth add $line
	done <<<"$XAUTH_LIST"

fi
