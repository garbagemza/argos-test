#!/bin/bash

is_linux() {
        case "$(uname -s)" in
        *linux* ) true ;;
        *Linux* ) true ;;
        * ) false;;
        esac
}

is_armv7() {
        case "$(uname -m)" in
        *armv7* ) true ;;
        * ) false ;;
        esac
}


do_install() {
    echo "[FN] executing argos pipeline install script"
    echo
    echo "platform:      $(uname -s)"
    echo "architecture:  $(uname -m)"
    echo

    make_directories
    download_pipeline $2
    build_images $1 $2
    clean_directories
}

make_directories() {
    echo "[FN] making working directories"
    mkdir -p argos/src
}

download_pipeline() {
    echo "[FN] downloading pipeline"
    git clone --depth 1 https://github.com/garbagemza/$1.git argos/src/$1
}

build_images() {
    echo "[FN] building image..."
    if is_linux && is_armv7; then
        build_raspberry_images $1 $2
    else
        echo "unknown platform for building image."
        exit 1
    fi
}

build_raspberry_images() {
    echo "[FN] building raspberry pi image"
    docker build -t $1 -f argos/src/$2/docker/raspberrypi3.dockerfile argos/src/$2
}

clean_directories() {
    echo "[FN] cleaning directories"
    rm -rf argos
}

# $1 container_name
# $2 repository_name
# call everything at last line so avoid problems downloading file.
do_install $1 $2