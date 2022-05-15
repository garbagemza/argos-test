#!/bin/bash

execute_all() {
    echo "[AZ] *** install everything ***"

    sh down-containers.sh argos-gateway argos-cache argos-repo
    sh pull-repositories.sh argos-gateway argos-repository-cache-job argos-repository-downloader-job
    sh build-image.sh argos-gateway argos-gateway
    sh build-image.sh argos-cache argos-repository-cache-job
    sh build-image.sh argos-repo argos-repository-downloader-job

    sh clean-repositories.sh
    sh prune-images.sh

    sh up-container.sh argos-gateway 80:8080
    sh up-container.sh argos-cache
    sh up-container.sh argos-repo

    sleep 5s

    bash liveness-probe.sh argos-gateway 80
    bash liveness-probe.sh argos-cache 8080
    bash liveness-probe.sh argos-repo 8081

    echo "[AZ] *** done ***"
}

# intentionally at bottom
execute_all


