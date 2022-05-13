#!/bin/bash

do_work() {
    echo "[AZ] downloading scripts"
    echo "[AZ] parameters:"
    echo "[AZ] container_name: $1"

    curl -s https://raw.githubusercontent.com/garbagemza/argos-test/main/down-container.sh -o down-container.sh
    curl -s https://raw.githubusercontent.com/garbagemza/argos-test/main/prune-image.sh -o prune-image.sh
    curl -s https://raw.githubusercontent.com/garbagemza/argos-test/main/install.sh -o install.sh
    curl -s https://raw.githubusercontent.com/garbagemza/argos-test/main/up-container.sh -o up-container.sh
    curl -s https://raw.githubusercontent.com/garbagemza/argos-test/main/liveness-probe.sh -o liveness-probe.sh

    echo "[AZ] executing scripts"
    echo

    sh down-container.sh $1
    sh install.sh $1
    sh up-container.sh $1
    sh prune-image.sh

    echo "[AZ] Sleeping 2 seconds to get last container up."
    sleep 2s

    bash liveness-probe.sh $1

    echo "[AZ] removing scripts"
    rm down-container.sh
    rm prune-image.sh
    rm install.sh
    rm up.sh
    rm liveness-probe.sh
}

check_params() {
        if [ -z "$1" ]; then
                echo "expected parameter 'container_name'."
                exit 1
        fi
}

check_params $1

# left intentionally at the bottom
do_work $1