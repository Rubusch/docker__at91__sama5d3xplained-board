#!/bin/bash -e
export DEFCONFIG=sama5d3_xplained_graphics_defconfig
cd ~/buildroot-at91
###
## don't use external repo
#make $DEFCONFIG
## or use external repo
BR2_EXTERNAL=../buildroot-external-microchip/ make $DEFCONFIG
###
make -j8
## not possible to mount the folder directly as 'output' inside the container
## buildroot's make then fails right in the beginning with:
##
##   *** Error during update of the configuration.
##

## obtain build artifacts
sudo chown $(whoami):$(whoami) -R ~/output
cp -arfL ~/buildroot-at91/output/* ~/output/
