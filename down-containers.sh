#!/bin/bash
# This script will down 0 .. n containers with name

do_work() {
    for name in "$@"
    do
        sh ./down-container.sh "$name"
    done
}

do_work $@