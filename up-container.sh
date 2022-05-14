#!/bin/bash

up_container() {
    echo "[FN] getting up docker container $1 at port $2"
    docker run --name $1 --rm -p $2:8080 -d -v /argos/data:/app/data --env PORT=8080 --env WORKDIR=/app/data $1
}

check_params() {
    if [ -z "$1" ]; then
        echo "expected parameter 'container_name'."
        exit 1
    fi
    if [ -z "$2" ]; then
        echo "expected parameter 'container_port'."
        exit 1
    fi
}

# $1 container_name
# $2 container_port
check_params $1 $2

# $1 container_name
# $2 container_port
# main function is called at the end to ensure the whole file is downloaded.
up_container $1 $2
