#!/bin/bash

set -eu

unset KAFKA_JMX_OPTS

${SNAP}/bin/${bin_script} "${@}"
