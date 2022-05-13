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

    echo "argos-cache $(curl http://localhost/health)"
}

# main function is called at the end to ensure the whole file is downloaded.
do_run
