#!/bin/bash

set -e

# Kraft uses the same var for JMX metrics. To allow both to be used on the same machine, 
# use a specific var for Kraft and override during startup.
if [ "x$KRAFT_JMX_OPTS" != "x" ]; then
    export KAFKA_JMX_OPTS=${KRAFT_JMX_OPTS}
else
    unset KAFKA_JMX_OPTS
fi

export LOG_DIR="${SNAP_COMMON}/var/log/kraft"

if [ "x$KAFKA_LOG4J_OPTS" = "x" ]; then
    export KAFKA_LOG4J_OPTS="-Dlog4j2.configurationFile=${SNAP_DATA}/etc/kraft/log4j2.yaml -Dcharmed.kafka.log.level=${KAFKA_CFG_LOGLEVEL:-INFO}"
fi

"${SNAP}"/usr/bin/setpriv \
    --clear-groups \
    --reuid _daemon_ \
    --regid _daemon_ -- \
    "${SNAP}/opt/kafka/bin/kafka-server-start.sh" "${SNAP_DATA}"/etc/kraft/controller.properties
