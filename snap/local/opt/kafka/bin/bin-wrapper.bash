#!/bin/bash

set -e

unset KAFKA_JMX_OPTS
export LOG_DIR="${SNAP_COMMON}/var/log/kafka"

if [ "x$KAFKA_LOG4J_OPTS" = "x" ]; then
    export KAFKA_LOG4J_OPTS="-Dlog4j2.configurationFile=file:${SNAP_DATA}/etc/kafka/tools-log4j2.yaml -Dcharmed.kafka.log.level=WARN",
fi

${SNAP}/opt/kafka/bin/${bin_script} "${@}"
