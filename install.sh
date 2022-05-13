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
    echo "executing argos pipeline install script"
    echo
    echo "platform detected:     $(uname -s)"
    echo "architecture detected: $(uname -m)"
    echo

    make_directories
    download_pipeline
    build_images
}

make_directories() {
    echo "making working directories"
    mkdir -p argos/data
    mkdir -p argos/src
}

download_pipeline() {
    echo "downloading pipeline"
    git clone --depth 1 https://github.com/garbagemza/argos-repository-cache-job.git argos/src/argos-repository-cache-job
}

build_images() {
    echo "building images..."
    if is_linux && is_armv7; then
        build_raspberry_images
    else
        echo "no es raspberry pi"
        exit 1
    fi
}

build_raspberry_images() {
    echo "building raspberry pi images"
    docker build -t argos-cache -f argos/src/argos-repository-cache-job/docker/raspberrypi3.dockerfile argos/src/argos-repository-cache-job
}
# call everything at last line so avoid problems downloading file.
do_install