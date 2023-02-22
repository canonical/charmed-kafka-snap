#!/bin/bash

set -eu

if [ ! -f "${SNAP_COMMON}"/exporter.properties ]
then
    echo "Missing exporter.properties from SNAP_COMMON"
    exit 1
fi


PROPERTIES=$(cat "${SNAP_COMMON}"/exporter.properties)
BOOTSTRAP_SERVERS=$(echo "${PROPERTIES}" | grep bootstrap.servers | sed 's/bootstrap\.servers=//g')
SECURITY_PROTOCOL=$(echo "${PROPERTIES}" | grep security.protocol | sed 's/security\.protocol=//g')
SASL_JAAS_CONFIG=$(echo $PROPERTIES | grep sasl.jaas.config | sed 's/sasl\.jaas\.config=//g')
PASSWORD=$(echo $SASL_JAAS_CONFIG | grep -oP "password\=\"([a-zA-Z0-9]+)" | cut -d "\"" -f 2)

for i in $(echo $BOOTSTRAP_SERVERS | tr "," "\n")
do
    args+=("--kafka.server=${i}")
done

if [ -n "$(echo "${SECURITY_PROTOCOL}" | grep "SSL")" ]
then
    args+=" --tls.enabled"
    args+=" --tls.ca-file=${SNAP_COMMON}/ca.pem"
    args+=" --tls.cert-file=${SNAP_COMMON}/server.pem"
    args+=" --tls.key-file=${SNAP_COMMON}/server.key"
fi

args+=" --sasl.enabled"
args+=" --sasl.mechansim=scram-sha512"
args+=" --sasl.username=exporter"
args+=" --sasl.password=${PASSWORD}"

"${SNAP}"/opt/kafka/kafka_exporter "${args[@]}"

