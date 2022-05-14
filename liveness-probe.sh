#!/bin/bash

liveness_probe() {
    echo "[FN] checking $1 at port $2 ... $(expect_health $2)"
}

check_health() {
    echo "$(curl -s http://localhost:$1/health)"
}

expect_health() {
    local result="$(check_health $1)"
    if [[ $result == "OK" ]]; then
        echo "PASSED."
    else
        echo "NOT PASSED."
    fi
}

check_params() {
    if [ -z "$1" ]; then
        echo "expected parameter 'container_name'."
        exit 1
    fi
    if [ -z "$2" ]; then
        echo "expected parameter 'container_port'."
        exit 1
    fi
}

# $1 container_name
# $2 container_port
check_params $1 $2

# $1 container_name
# $2 container_port
# main function is called at the end to ensure the whole file is downloaded.
liveness_probe $1 $2
