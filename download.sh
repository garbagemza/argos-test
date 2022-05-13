#!/bin/bash

do_work() {
    echo "[AZ] downloading scripts"
    echo

    curl https://raw.githubusercontent.com/garbagemza/argos-test/main/down-containers.sh -o down-containers.sh
    curl https://raw.githubusercontent.com/garbagemza/argos-test/main/down-images.sh -o down-images.sh
    curl https://raw.githubusercontent.com/garbagemza/argos-test/main/install.sh -o install.sh
    curl https://raw.githubusercontent.com/garbagemza/argos-test/main/up.sh -o up.sh
    curl https://raw.githubusercontent.com/garbagemza/argos-test/main/liveness-probe.sh -o liveness-probe.sh

    echo "[AZ] executing scripts"
    echo

    sh down-containers.sh
    sh down-images.sh
    sh install.sh
    sh up.sh
    sh liveness-probe.sh

    echo "[AZ] removing scripts"
    rm down-containers.sh
    rm down-images.sh
    rm install.sh
    rm up.sh
    rm liveness-probe.sh
}

# left intentionally at the bottom
do_work