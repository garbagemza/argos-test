#!/bin/bash

execute_all() {
    echo "[AZ] *** install everything ***"

    sh down-containers.sh argos-bff argos-gateway argos-cache argos-repo argos-deploy
    sh pull-repositories.sh argos-bff argos-gateway argos-repository-cache-job argos-repository-downloader-job argos-deployer-job
    sh build-image.sh argos-bff argos-bff
    sh build-image.sh argos-gateway argos-gateway
    sh build-image.sh argos-cache argos-repository-cache-job
    sh build-image.sh argos-repo argos-repository-downloader-job
    sh build-image.sh argos-deploy argos-deployer-job

    sh clean-repositories.sh
    sh prune-images.sh

    sh up-container.sh argos-bff $1/argos-bff 80:8080
    sh up-container.sh argos-gateway $1/argos-gateway
    sh up-container.sh argos-cache $1/argos-cache
    sh up-container.sh argos-repo $1/argos-repo
    sh up-container.sh argos-deploy $1/argos-deploy

    sleep 5s

    bash liveness-probe.sh argos-bff 80

    echo "[AZ] *** done ***"
}

check_params() {
    if [ -z "$1" ]; then
        echo "expected parameter 'base_mount_path'."
        exit 1
    fi
}
# $1 base_mount_path
check_params $1

# intentionally at bottom
execute_all $1
