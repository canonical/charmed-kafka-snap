#!/bin/bash

set -e

unset KAFKA_JMX_OPTS

if [ "x$KAFKA_LOG4J_OPTS" = "x" ]; then
    export KAFKA_LOG4J_OPTS="-Dcruisecontrol.logs.dir=${LOG_DIR} -Dlog4j.configurationFile=${SNAP_DATA}/etc/cruise-control/log4j.properties"
fi

"${SNAP}"/usr/bin/setpriv \
    --clear-groups \
    --reuid snap_daemon \
    --regid snap_daemon -- \
    "${SNAP}/opt/cruise-control/bin/kafka-cruise-control-start.sh" "${SNAP_DATA}"/etc/cruise-control/cruisecontrol.properties

