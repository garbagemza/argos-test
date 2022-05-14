#!/bin/bash
script_full_path=$(dirname "$0")

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
        sh $script_full_path/pull-repository.sh "$name" "argos/src"
    done

}


# left intentionally at the bottom
do_work $@