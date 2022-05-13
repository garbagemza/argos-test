#!/bin/bash

do_work() {
    curl https://raw.githubusercontent.com/garbagemza/argos-test/main/install.sh -o install.sh
    curl https://raw.githubusercontent.com/garbagemza/argos-test/main/down.sh -o down.sh
    curl https://raw.githubusercontent.com/garbagemza/argos-test/main/up.sh -o up.sh

    sh down.sh
    sh install.sh
    sh up.sh
}

# left intentionally at the bottom
do_work