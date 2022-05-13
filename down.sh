#!/bin/bash

# TODO: this should be run by docker-compose
do_run() {
    echo
    echo "This is the down pipeline script."
    echo "this will down all argos containers."
    echo
    down_containers
}

down_containers() {
    echo "[FN] getting down docker containers"
    docker container stop $(docker container ls -q --filter name=argos*)
}

# main function is called at the end to ensure the whole file is downloaded.
do_run
