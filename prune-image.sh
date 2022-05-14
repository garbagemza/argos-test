#!/bin/bash

prune_images() {
    echo "[FN] removing obsolete docker image."
    docker image prune -f
}

# main function is called at the end to ensure the whole file is downloaded.
prune_images
