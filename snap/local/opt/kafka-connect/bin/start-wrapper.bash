#!/bin/bash

set -e

if [ "x$KAFKA_LOG4J_OPTS" = "x" ]; then
    export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:${SNAP_DATA}/etc/kafka-connect/connect-log4j.properties"
fi

"${SNAP}"/usr/bin/setpriv \
    --clear-groups \
    --reuid snap_daemon \
    --regid snap_daemon -- \
    "${SNAP}/opt/kafka/bin/connect-distributed.sh" "${SNAP_DATA}"/etc/kafka-connect/connect.properties
