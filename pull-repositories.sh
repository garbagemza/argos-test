#!/bin/bash

do_work() {
    make_directories
    download_repositories $@
}

make_directories() {
    echo "[FN] making working directories"
    mkdir -p argos/src
}

download_repositories() {
    for name in "$@"
    do
        sh ./pull-repository.sh "$name" "argos/src"
    done

}


# left intentionally at the bottom
do_work $@