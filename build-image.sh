#!/bin/bash

is_linux() {
        case "$(uname -s)" in
        *linux* ) true ;;
        *Linux* ) true ;;
        * ) false;;
        esac
}

is_mac() {
    case "$(uname -s)" in
    *darwin* ) true ;;
    *Darwin* ) true ;;
    * ) false;;
    esac
}

is_armv7() {
        case "$(uname -m)" in
        *armv7* ) true ;;
        * ) false ;;
        esac
}

is_arm64() {
    case "$(uname -m)" in
    *arm64* ) true ;;
    * ) false;;
    esac
}

build_image() {
    echo "[FN] building image..."
    if is_linux && is_armv7; then
        build_raspberrypi_image $1 $2
    elif is_mac && is_arm64; then
        build_mac_m1_image $1 $2
    else
        echo "unknown platform for building image."
        exit 1
    fi
}

build_raspberrypi_image() {
    echo "[FN] building $1 raspberry pi image from $2"
    docker build --no-cache -t $1 -f argos/src/$2/docker/raspberrypi3.dockerfile argos/src/$2
}

build_mac_m1_image() {
    echo "[FN] building $1 mac m1 image from $2"
    docker build --no-cache -t $1 -f argos/src/$2/docker/arm64v8.dockerfile argos/src/$2
}

check_params() {
    if [ -z "$1" ]; then
        echo "expected parameter 'container_name'."
        exit 1
    fi
    if [ -z "$2" ]; then
        echo "expected parameter 'repository_name'."
        exit 1
    fi
}

# $1 container_name
# $2 repository_name
check_params $1 $2

# left intentionally at the bottom
build_image $1 $2