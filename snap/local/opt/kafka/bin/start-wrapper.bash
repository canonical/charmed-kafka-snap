#!/bin/bash

set -e

if [ "x$KAFKA_LOG4J_OPTS" = "x" ]; then
    export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:${SNAP_DATA}/etc/kafka/log4j.properties -Dcharmed.kafka.log.level=${KAFKA_CFG_LOGLEVEL:-INFO}"
fi

"${SNAP}"/usr/bin/setpriv \
    --clear-groups \
    --reuid snap_daemon \
    --regid snap_daemon -- \
    "${SNAP}/opt/kafka/bin/kafka-server-start.sh" "${SNAP_DATA}"/etc/kafka/server.properties
