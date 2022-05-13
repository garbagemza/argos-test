#!/bin/bash
is_linux() {
    case "$(uname -s)" in
    *linux* ) true ;;
    *Linux* ) true ;;
    * ) false;;
    esac
}

do_install() {
    echo "executing argos pipeline install script"
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
    echo "building cache..."
    #docker build -t argos-cache argos/src/argos-repository-cache-job
    if is_linux; then
        echo "running linux!"
    else
        echo "not running linux"
    fi
}

# call everything at last line so avoid problems downloading file.
do_install