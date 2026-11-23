#!/bin/bash

set -e

unset KAFKA_OPTS KAFKA_JMX_OPTS KAFKA_HEAP_OPTS KAFKA_JVM_PERFORMANCE_OPTS

if [ -f "${SNAP_DATA}/etc/connect/connect-env.sh" ]; then
    set -a
    . "${SNAP_DATA}/etc/connect/connect-env.sh"
    set +a
fi

if [ "x$KAFKA_LOG4J_OPTS" = "x" ]; then
    export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:${SNAP_DATA}/etc/connect/log4j.properties -Dcharmed.kafka.log.level=INFO",
fi

${SNAP}/opt/kafka/bin/connect-distributed.sh "${SNAP_DATA}"/etc/connect/connect-distributed.properties
