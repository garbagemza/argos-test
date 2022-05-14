#!/bin/bash

down_container() {
    echo "[FN] getting down docker container $1"
    docker container stop $(docker container ls -q --filter name=$1)
}

check_params() {
    if [ -z "$1" ]; then
        echo "expected parameter 'container_name'."
        exit 1
    fi
}

# $1 container_name
check_params $1

# $1 container name
# main function is called at the end to ensure the whole file is downloaded.
down_container $1
