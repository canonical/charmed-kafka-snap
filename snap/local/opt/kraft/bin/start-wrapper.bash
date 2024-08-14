#!/bin/bash

set -e

# Kraft uses the same var for JMX metrics. To allow both to be used on the same machine, 
# use a specific var for Kraft and override during startup.
if [ "x$KRAFT_JMX_OPTS" != "x" ]; then
    export KAFKA_JMX_OPTS=${KRAFT_JMX_OPTS}
else
    unset KAFKA_JMX_OPTS
fi

if [ "x$KAFKA_LOG4J_OPTS" = "x" ]; then
    export KAFKA_LOG4J_OPTS="-Dcontroller.logs.dir=${LOG_DIR} -Dlog4j.configuration=file:${SNAP_DATA}/etc/kraft/log4j.properties -Dcharmed.kafka.log.level=${KAFKA_CFG_LOGLEVEL:-INFO}"
fi

"${SNAP}"/usr/bin/setpriv \
    --clear-groups \
    --reuid snap_daemon \
    --regid snap_daemon -- \
    "${SNAP}/opt/kafka/bin/kafka-server-start.sh" "${SNAP_DATA}"/etc/kraft/controller.properties
