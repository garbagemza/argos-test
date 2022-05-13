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
    download_pipeline
    build_images $1
    clean_directories
}

make_directories() {
    echo "[FN] making working directories"
    mkdir -p argos/src
}

download_pipeline() {
    echo "[FN] downloading pipeline"
    git clone --depth 1 https://github.com/garbagemza/argos-repository-cache-job.git argos/src/argos-repository-cache-job
}

build_images() {
    echo "[FN] building images..."
    if is_linux && is_armv7; then
        build_raspberry_images $1
    else
        echo "unknown platform for building images."
        exit 1
    fi
}

build_raspberry_images() {
    echo "[FN] building raspberry pi images"
    docker build --no-cache -t $1 -f argos/src/argos-repository-cache-job/docker/raspberrypi3.dockerfile argos/src/argos-repository-cache-job
}

clean_directories() {
    echo "[FN] cleaning directories"
    rm -rf argos
}

# $1 container_name
# call everything at last line so avoid problems downloading file.
do_install $1