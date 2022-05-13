#!/bin/bash

# TODO: this should be run by docker-compose
do_run() {
    echo
    echo "This is the down-container pipeline script."
    echo "this will down all argos container."
    echo
    down_container $1
}

down_container() {
    echo "[FN] getting down docker container"
    docker container stop $(docker container ls -q --filter name=$1)
}

# $1 container name
# main function is called at the end to ensure the whole file is downloaded.
do_run $1
