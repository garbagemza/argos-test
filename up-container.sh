#!/bin/bash

up_container() {
    echo "[FN] getting up docker container $1 with port binding $2"
    docker run --network argos-net --name $1 --rm $(port_param $2) -d -v /argos/data:/app/data --env PORT=8080 --env WORKDIR=/app/data $1
}

check_params() {
    if [ -z "$1" ]; then
        echo "expected parameter 'container_name'."
        exit 1
    fi
}

port_param() {
    if [ -z "$1" ]; then
        echo ""
    else
        echo "-p $1"
    fi
}

# $1 container_name
check_params $1

# $1 container_name
# $2 container_port (optional i.e.: 80:8080)
# main function is called at the end to ensure the whole file is downloaded.
up_container $1 $2
