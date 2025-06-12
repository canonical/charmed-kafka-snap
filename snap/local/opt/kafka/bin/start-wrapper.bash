#!/bin/bash

set -e

if [ "x$KAFKA_LOG4J_OPTS" = "x" ]; then
    export KAFKA_LOG4J_OPTS="-Dlog4j2.configurationFile=file:${SNAP_DATA}/etc/kafka/log4j2.yaml -Dcharmed.kafka.log.level=${KAFKA_CFG_LOGLEVEL:-INFO}"
fi

"${SNAP}"/usr/bin/setpriv \
    --clear-groups \
    --reuid _daemon_ \
    --regid _daemon_ -- \
    "${SNAP}/opt/kafka/bin/kafka-server-start.sh" "${SNAP_DATA}"/etc/kafka/server.properties
