#!/bin/bash

set -eu

export CONFIG_FILE="${SNAP_COMMON}/server.properties"
if [ ! -f "${CONFIG_FILE}" ]; then
	echo "custom configuration file ${CONFIG_FILE} does not exist."
	echo "Using default config ${CONFIG_FILE}"
	export CONFIG_FILE="${SNAP}/opt/kafka/config/server.properties"
fi

# Use custom log4j properties if found
if [ -f "${SNAP_COMMON}/log4j.properties" ]; then
	export KAFKA_LOG4J_OPTS="-Dlog4j.configuration=file:${SNAP_COMMON}/log4j.properties"
fi

export PATH="${SNAP}/usr/lib/jvm/default-java/bin:${PATH}"
export LOG_DIR="${SNAP_COMMON}/log"

# Inject the JMX exporter if we're running Kafka itself
JMX_EXPORTER_PATH="${SNAP}/opt/kafka/extra/jmx_prometheus_javaagent.jar"
JMX_EXPORTER_CONF="${SNAP}/opt/kafka/default-config/jmx_prometheus.yaml"
JMX_PORT="9101"
export KAFKA_OPTS="${KAFKA_OPTS:+$KAFKA_OPTS }-javaagent:${JMX_EXPORTER_PATH}=${JMX_PORT}:${JMX_EXPORTER_CONF}"

if [ -e "${SNAP_COMMON}/broker.env" ]; then
	. "${SNAP_COMMON}/broker.env"
fi

"${SNAP}/opt/kafka/bin/kafka-server-start.sh" "${CONFIG_FILE}"
