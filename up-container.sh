#!/bin/bash

# TODO: this should be run by docker-compose
do_run() {
    echo
    echo "This is the up pipeline script."
    echo "this will up $1 container."
    echo
    up_container $1
}

up_container() {
    echo "[FN] getting up docker container"
    docker run --name $1 --rm -p 80:8080 -d -v /argos/data:/app/data --env PORT=8080 --env WORKDIR=/app/data argos-cache
}

# $1 container_name
# main function is called at the end to ensure the whole file is downloaded.
do_run $1
