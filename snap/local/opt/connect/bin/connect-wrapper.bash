#!/bin/bash

set -e

unset KAFKA_JMX_OPTS

if [ "x$KAFKA_LOG4J_OPTS" = "x" ]; then
    export KAFKA_LOG4J_OPTS="-Dlog4j2.configurationFile=${SNAP_DATA}/etc/connect/log4j2.yaml -Dcharmed.kafka.log.level=INFO",
fi

${SNAP}/opt/kafka/bin/connect-distributed.sh "${SNAP_DATA}"/etc/connect/connect-distributed.properties
