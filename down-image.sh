#!/bin/bash

# TODO: this should be run by docker-compose
do_run() {
    echo
    echo "This is the down-image pipeline script."
    echo "this will remove an image."
    echo
    down_image $1
}

down_image() {
    echo "[FN] removing obsolete docker image."
    docker image rm $(docker image ls -q --filter reference=$1)
}

# $1 container_name - image_name
# main function is called at the end to ensure the whole file is downloaded.
do_run $1
