#!/bin/bash

set -e

# Cruise control uses the same var for JMX metrics. To allow both to be used on the same machine, 
# use a specific var for CC and override during startup.
if [ "x$CC_JMX_OPTS" != "x" ]; then
    export KAFKA_JMX_OPTS=${CC_JMX_OPTS}
else
    unset KAFKA_JMX_OPTS
fi

if [ "x$KAFKA_LOG4J_OPTS" = "x" ]; then
    export KAFKA_LOG4J_OPTS="-Dcruisecontrol.logs.dir=${LOG_DIR} -Dlog4j.configurationFile=${SNAP_DATA}/etc/cruise-control/log4j.properties -Dcruisecontrol.log.level=${KAFKA_CFG_LOGLEVEL:-INFO}"
fi

"${SNAP}"/usr/bin/setpriv \
    --clear-groups \
    --reuid snap_daemon \
    --regid snap_daemon -- \
    "${SNAP}/opt/cruise-control/bin/kafka-cruise-control-start.sh" "${SNAP_DATA}"/etc/cruise-control/cruisecontrol.properties

