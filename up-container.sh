#!/bin/bash

up_container() {
    echo "[FN] getting up docker container $1 with port binding $3"
    docker run --network argos-net --rm --name $1 $(port_param $3) -d -v $2:/app/data --env PORT=8080 --env WORKDIR=/app/data $1
}

port_param() {
    if [ -z "$1" ]; then
        echo ""
    else
        echo "-p $1"
    fi
}

check_params() {
    if [ -z "$1" ]; then
        echo "expected parameter 'container_name'."
        exit 1
    fi
    if [ -z "$2" ]; then
        echo "expected parameter 'host_path'."
        exit 1
    fi
}


# $1 container_name
check_params $1 $2 $3

# $1 container_name
# $2 host_path
# $3 container_port (optional i.e.: 80:8080)
# main function is called at the end to ensure the whole file is downloaded.
up_container $1 $2 $3
