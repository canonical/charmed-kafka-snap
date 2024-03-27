#!/bin/bash

set -e

unset KAFKA_JMX_OPTS
unset KAFKA_LOG4J_OPTS


${SNAP}/opt/kafka/bin/${bin_script} "${@}"
