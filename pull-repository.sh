#!/bin/bash

download_repository() {
    echo "[FN] downloading repository"
    git clone --depth 1 https://github.com/garbagemza/$1.git $2/$1
}

check_params() {
    if [ -z "$1" ]; then
        echo "expected parameter 'repository_name'."
        exit 1
    fi
    if [ -z "$2" ]; then
        echo "expected parameter 'base_dir'."
        exit 1
    fi
}

# $1 repository_name
# $2 base_dir
check_params $1 $2

# left intentionally at the bottom
download_repository $1 $2