#!/bin/sh -e
## provide a .setup file to get this script more independent, e.g.
## $ cat .setup
##	BASE_IMAGE="zephyr-base"
##
## by the BASE_IMAGE name the script will read the used tag in
##	./docker*/build_context/Dockerfile
##
## when called with any argument, the script will only build the container
## images, where normally it would execute the default build script on
## the images

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

if [ ! -f "./.setup" ]; then
	echo "FAILED: '.setup' file missing"
	exit 1
fi
. ./.setup
test -z "${DOCKERDIR}" && DOCKERDIR="docker"
BASE_IMAGE_TAG="$(grep "ARG DOCKER_BASE_TAG" -r "${DOCKERDIR}/build_context/Dockerfile" | awk -F= '{ print $2 }' | tr -d '"')"

## assure base image container
CONTAINER="$(docker images | grep "${BASE_IMAGE}" | grep "${BASE_IMAGE_TAG}" | awk '{print $3}')"
if [ -z "${CONTAINER}" ]; then
	git clone "https://github.com/Rubusch/docker__${BASE_IMAGE}.git" "${BASE_IMAGE}"
	cd "${BASE_IMAGE}"
	git checkout "${BASE_IMAGE_TAG}"
	cd -
	build "./${BASE_IMAGE}/docker" "${DRYRUN}"
	## check again, if container was _really_ build now
	CONTAINER="$(docker images | grep "${BASE_IMAGE}" | grep "${BASE_IMAGE_TAG}" | awk '{print $3}')"
	if [ -z "${CONTAINER}" ]; then
		echo "FAILED: container '${CONTAINER}' was not build"
		exit 1
	fi
fi

## build overlay container
build "./${DOCKERDIR}" "${DRYRUN}"
echo "READY."
