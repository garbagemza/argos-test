#!/bin/bash

# TODO: this should be run by docker-compose
do_run() {
    echo
    echo "This is the up pipeline script."
    echo "this will up all argos containers."
    echo
    up_containers

    echo "Sleeping 5 seconds to get last container up."
    sleep 5s
}

up_containers() {
    echo "[FN] getting up docker containers"
    docker run --name argos-cache --rm -p 80:8080 -d -v /argos/data:/app/data --env PORT=8080 --env WORKDIR=/app/data argos-cache
}

# main function is called at the end to ensure the whole file is downloaded.
do_run
