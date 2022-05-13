#!/bin/bash

do_run() {
    echo
    echo "This is the liveness probe."
    echo "this will test if all argos services are up."
    echo
    liveness_probe
}

liveness_probe() {
    echo "[FN] executing liveness probe for containers"
    echo
    echo "checking argos-cache $(expect_health 80)"
    echo
}

check_health() {
    echo "$(curl -s http://localhost:$1/health)"
}

expect_health() {
    local result="$(check_health $1)"
    if [[ $result == "OK" ]]; then
        echo "passed"
    else
        echo "not passed"
    fi
}

# main function is called at the end to ensure the whole file is downloaded.
do_run
