#!/bin/bash

do_run() {
    echo
    echo "This is the liveness probe."
    echo "this will test if $1 service is up at port $2."
    echo
    liveness_probe $1 $2
}

liveness_probe() {
    echo "[FN] executing liveness probe for container $1."
    echo
    echo "checking $1 $(expect_health $2)"
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

# $1 container_name
# $2 container_port
# main function is called at the end to ensure the whole file is downloaded.
do_run $1 $2
