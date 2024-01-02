#!/bin/bash

set -e

unset KAFKA_JMX_OPTS

if [ "x$KAFKA_LOG4J_OPTS" = "x" ]; then
    export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:${SNAP_DATA}/etc/kafka/tools-log4j.properties"
fi

${SNAP}/opt/kafka/bin/${bin_script} "${@}"
