#!/bin/bash
# This script will down 0 .. n containers with name
script_full_path=$(dirname "$0")

do_work() {
    for name in "$@"
    do
        sh $script_full_path/down-container.sh "$name"
    done
}

do_work $@