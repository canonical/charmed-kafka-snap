#!/bin/bash

set -eu

export PATH="${SNAP}/usr/lib/jvm/default-java/bin:${PATH}"
unset JAVA_HOME

export LOG_DIR="${SNAP_COMMON}/log"

"${SNAP}/opt/kafka/bin/${_wrapper_script}" "${@}"
