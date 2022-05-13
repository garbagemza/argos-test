#!/bin/bash

# TODO: this should be run by docker-compose
do_run() {
    echo
    echo "This is the down-images pipeline script."
    echo "this will remove all argos images."
    echo
    down_images
}

down_images() {
    echo "[FN] removing obsolete docker images."
    docker image rm $(docker image ls -q --filter reference=argos*)
}

# main function is called at the end to ensure the whole file is downloaded.
do_run
