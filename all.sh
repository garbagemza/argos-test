#!/bin/bash

execute_all() {
    echo "[AZ] *** install everything ***"

    sh down-containers.sh argos-bff argos-gateway argos-cache argos-repo
    sh pull-repositories.sh argos-bff argos-gateway argos-repository-cache-job argos-repository-downloader-job
    sh build-image.sh argos-bff argos-bff
    sh build-image.sh argos-gateway argos-gateway
    sh build-image.sh argos-cache argos-repository-cache-job
    sh build-image.sh argos-repo argos-repository-downloader-job

    sh clean-repositories.sh
    sh prune-images.sh

    sh up-container.sh argos-cache
    sh up-container.sh argos-repo
    sh up-container.sh argos-gateway
    sh up-container.sh argos-bff 80:8080

    sleep 5s

    bash liveness-probe.sh argos-bff 80

    echo "[AZ] *** done ***"
}

# intentionally at bottom
execute_all


