#!/bin/bash

do_run() {
    echo
    echo "This is the prune image pipeline script."
    echo "this will prune unused images."
    echo
    prune_images
}

prune_images() {
    echo "[FN] removing obsolete docker image."
    docker image prune -f
}

# $1 container_name - image_name
# main function is called at the end to ensure the whole file is downloaded.
do_run
