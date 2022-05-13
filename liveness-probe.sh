#!/bin/bash

do_run() {
    echo
    echo "This is the liveness probe."
    echo "this will test if service is up at port $1."
    echo
    liveness_probe $1
}

liveness_probe() {
    echo "[FN] executing liveness probe for containers"
    echo
    echo "checking argos-cache $(expect_health $1)"
    echo
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

# $1 container_port
# main function is called at the end to ensure the whole file is downloaded.
do_run $1
