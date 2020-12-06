#!/bin/bash -e
export USER="$(whoami)"
export MY_HOME="/home/${USER}"
export BUILDDIR="${MY_HOME}/buildroot-at91"

export DEFCONFIG=sama5d3_xplained_graphics_defconfig

sudo chown ${USER}:${USER} -R ${BUILDDIR}/output
sudo chown ${USER}:${USER} -R ${BUILDDIR}/dl

cd ${BUILDDIR}

###
## don't use external repo
#make $DEFCONFIG

## or use external repo
BR2_EXTERNAL=../buildroot-external-microchip/ make defconfig $DEFCONFIG

###
make -j8

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
