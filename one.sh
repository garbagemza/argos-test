#!/bin/bash

execute_all() {
    echo "[AZ] *** install $1 ***"

    sh down-containers.sh $1
    sh pull-repositories.sh $2
    sh build-image.sh $1 $2

    sh clean-repositories.sh
    sh prune-images.sh

    sh up-container.sh $1 $3

    sleep 5s

    bash liveness-probe.sh $1 $3

    echo "[AZ] *** done ***"
}

check_params() {
    if [ -z "$1" ]; then
        echo "expected parameter 'container_name'."
        exit 1
    fi
    if [ -z "$2" ]; then
        echo "expected parameter 'repository_name'."
        exit 1
    fi
    if [ -z "$3" ]; then
        echo "expected parameter 'container_port'."
        exit 1
    fi
}

# $1 container_name
# $1 repository_name
# $2 container_port
check_params $1 $2 $3

# intentionally at bottom
execute_all $1 $2 $3


