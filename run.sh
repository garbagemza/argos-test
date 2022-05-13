
# TODO: this should be run by docker-compose
do_run() {
    echo
    echo "This is the run pipeline script."
    echo
    down_containers
    #up_containers
    #echo "[FN] getting up docker containers"
    #docker run --rm -p 80:8080 -d -v /argos/data:/app/data --env PORT=8080 --env WORKDIR=/app/data argos-cache
}

down_containers() {
    echo "[FN] getting down docker containers"
    docker container stop $(docker container ls -q --filter name=argos*)
}

docker container ls -q --filter name=argos*
# main function is called at the end to ensure the whole file is downloaded.
do_run
