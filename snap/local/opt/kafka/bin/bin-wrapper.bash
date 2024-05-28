#!/bin/bash

set -e

unset KAFKA_JMX_OPTS

${SNAP}/opt/kafka/bin/${bin_script} "${@}"
