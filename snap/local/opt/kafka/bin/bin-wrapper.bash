#!/bin/bash

set -e

unset KAFKA_JMX_OPTS

if [ "x$KAFKA_LOG4J_OPTS" = "x" ]; then
    export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:${SNAP_DATA}/etc/kafka/tools-log4j.properties -Dcharmed.kafka.log.level=WARN",
fi

"${SNAP}"/usr/bin/setpriv \
    --clear-groups \
    --reuid snap_daemon \
    --regid snap_daemon -- \
    ${SNAP}/opt/kafka/bin/${bin_script} "${@}"
