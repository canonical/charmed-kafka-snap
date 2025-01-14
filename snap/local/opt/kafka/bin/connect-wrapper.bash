#!/bin/bash

set -e

unset KAFKA_JMX_OPTS

if [ "x$KAFKA_LOG4J_OPTS" = "x" ]; then
    export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:${SNAP_DATA}/etc/kafka/log4j.properties -Dcharmed.kafka.log.level=INFO",
fi

${SNAP}/opt/kafka/bin/connect-distributed.sh "${SNAP_DATA}"/etc/kafka/connect-distributed.properties
