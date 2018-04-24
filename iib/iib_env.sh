#!/bin/sh

if [ -z "$MQSI_VERSION" ]; then
	source "/opt/ibm/iib/server/bin/mqsiprofile" &>/dev/null
fi
