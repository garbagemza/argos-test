#!/bin/bash

do_work() {
    echo "[AZ] downloading scripts"
    echo

    curl https://raw.githubusercontent.com/garbagemza/argos-test/main/install.sh -o install.sh
    curl https://raw.githubusercontent.com/garbagemza/argos-test/main/down.sh -o down.sh
    curl https://raw.githubusercontent.com/garbagemza/argos-test/main/up.sh -o up.sh

    echo "[AZ] executing scripts"
    echo

    sh down.sh
    sh install.sh
    sh up.sh

    echo "[AZ] removing scripts"
    rm down.sh
    rm install.sh
    rm up.sh
}

# left intentionally at the bottom
do_work