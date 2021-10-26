#!/bin/sh -e

MY_USER="$(whoami)"
MY_HOME="/home/${MY_USER}"
SSH_DIR="${MY_HOME}/.ssh"
SSH_KNOWN_HOSTS="${SSH_DIR}/known_hosts"
BR_DIR="${MY_HOME}/buildroot"
BUILD_DIR="${BR_DIR}/buildroot-at91"
BR_DEFCONFIG="sama5d3_xplained_graphics_defconfig"

BRANCH="2020.02-at91"

## permissions
for item in "${BR_DIR}" "${SSH_DIR}" "${MY_HOME}/.gitconfig"; do
    if [ ! "${MY_USER}" == "$( stat -c %U ${item} )" ]; then
        ## may take some time
        sudo chown "${MY_USER}:${MY_USER}" -R ${item}
    fi
done

## ssh known_hosts
touch ${SSH_KNOWN_HOSTS}
for item in "github.com" "bitbucket.org"; do
    if [ "" == "$( grep ${item} -r ${SSH_KNOWN_HOSTS} )" ]; then
        ssh-keyscan "${item}" >> "${SSH_KNOWN_HOSTS}"
    fi
done

## initial clone
FIRST="$(ls -A "${BR_DIR}")"
if [ -z "${FIRST}" ]; then
    cd "${BR_DIR}"
    git clone --branch "lothar/${BRANCH}" -j4 https://github.com/Rubusch/buildroot-at91.git
    git clone --branch "${BRANCH}" https://github.com/linux4sam/buildroot-external-microchip.git
fi


###
cd "${BUILD_DIR}"
## don't use external repo
#make $BR_DEFCONFIG
## or use external repo
BR2_EXTERNAL="../buildroot-external-microchip/" make defconfig "${BR_DEFCONFIG}"

make -j "$(nproc)"

## obtain build artifacts with a separate copy step
##
## not possible to mount the folder directly as 'output' inside the
## container buildroot's make then fails right in the beginning with:
##
##   *** Error during update of the configuration.
##
## This happence since, the c function in kbuild is not able to
## deal with mounted devices / cross device links (in other containers
## I implemented a patch for that), now copy the build artifacts after
## the build in a separate step
#cp -arfL ~/buildroot-at91/output/* ~/output/
##
## fixed: by reimplementing a file_move() inside kconfig of buildroot fixes this
