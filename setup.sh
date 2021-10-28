#!/bin/sh -e
build()
{
	CONTAINER_NAME="$(grep "container_name:" -r "${1}/docker-compose.yml" | awk -F: '{ print $2 }' | tr -d ' ')"
	cd "${1}"
	echo "UID=$(id -u)" > .env
	echo "GID=$(id -g)" >> .env
	if [ -n "${2}" ]; then
	    docker-compose build
	else
	    docker-compose up --exit-code-from "${CONTAINER_NAME}"
	fi
	cd -
}

DRYRUN="${1}"

## base image
IMAGE="sandbox"
test -z "${DOCKERDIR}" && DOCKERDIR="docker"

TAG="$(grep "ARG DOCKER_BASE_TAG" -r "${DOCKERDIR}/build_context/Dockerfile" | awk -F= '{ print $2 }' | tr -d '"')"

CONTAINER="$(docker images | grep "${IMAGE}" | grep "${TAG}" | awk '{print $3}')"

if [ -z "${CONTAINER}" ]; then
	git clone "https://github.com/Rubusch/docker__${IMAGE}.git" "${IMAGE}"
	build "./${IMAGE}/docker" "${DRYRUN}"
fi

## docker container
build "./${DOCKERDIR}" "${DRYRUN}"

echo "READY."
