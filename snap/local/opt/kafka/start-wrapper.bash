#!/bin/bash

set -e

"${SNAP}"/usr/bin/setpriv \
    --clear-groups \
    --reuid snap_daemon \
    --regid snap_daemon -- \
    "${SNAP}/bin/kafka-server-start.sh" "${SNAP_DATA}"/etc/kafka/server.properties
