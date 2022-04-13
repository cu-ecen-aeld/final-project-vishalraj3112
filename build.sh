#!/bin/bash
# Script to build image for qemu.
# Author: Siddhant Jajoo, Vishal Raj.

git submodule init
git submodule sync
git submodule update

# local.conf won't exist until this step on first execution
source poky/oe-init-build-env

CONFLINE="MACHINE = \"raspberrypi3\""

#Create image of the type rpi-sdimg
IMAGE="IMAGE_FSTYPES = \"wic.bz2\""

#Set GPU memory as minimum
MEMORY="GPU_MEM = \"16\""

#--------------QT5 Support--------------------
#Add any packages needed
ADD_PACK="CORE_IMAGE_EXTRA_INSTALL += \"cserver client gui\""

#CORE_IM_ADD="CORE_IMAGE_EXTRA_INSTALL += \"aesdsocket-new\""

IMAGE_ADD="IMAGE_INSTALL:append =  \"qtbase \
    qtbase-dev \
    qtbase-mkspecs \
    qtbase-plugins \
    qtbase-tools \
    qt3d \
    qt3d-dev \
    qt3d-mkspecs \
    qtcharts \
    qtcharts-dev \
    qtcharts-mkspecs \
    qtconnectivity-dev \
    qtconnectivity-mkspecs \
    qtquickcontrols2 \
    qtquickcontrols2-dev \
    qtquickcontrols2-mkspecs \
    qtdeclarative \
    qtdeclarative-dev \
    qtdeclarative-mkspecs \
    qtgraphicaleffects \
    qtgraphicaleffects-dev \
    linux-firmware-bcm43430 \
    bluez5 \
    i2c-tools \
    bridge-utils \
    hostapd \
    iptables \
    wpa-supplicant \""
    #aesdsocket-new \""
    #aesd-assignments \""
    #aesdsocket_new  \""

#--------------QT5 Support--------------------

#Add wifi support
DISTRO_F="DISTRO_FEATURES:append = \"wifi\""
#add firmware support 
IMAGE_ADD="IMAGE_INSTALL:append = \"linux-firmware-rpidistro-bcm43430 v4l-utils python3 ntp wpa-supplicant\""

#Licence
LICENCE="LICENSE_FLAGS_ACCEPTED  = \"commercial\""

#IMAGE_F="IMAGE_FEATURES += \"ssh-server-openssh\""
IMAGE_F="IMAGE_FEATURES += \"ssh-server-openssh tools-sdk tools-debug\""

cat conf/local.conf | grep "${CONFLINE}" > /dev/null
local_conf_info=$?

cat conf/local.conf | grep "${IMAGE}" > /dev/null
local_image_info=$?

cat conf/local.conf | grep "${MEMORY}" > /dev/null
local_memory_info=$?

cat conf/local.conf | grep "${DISTRO_F}" > /dev/null
local_distro_info=$?

cat conf/local.conf | grep "${IMAGE_ADD}" > /dev/null
local_imgadd_info=$?

cat conf/local.conf | grep "${LICENCE}" > /dev/null
local_licn_info=$?

cat conf/local.conf | grep "${IMAGE_F}" > /dev/null
local_imgf_info=$?

cat conf/local.conf | grep "${ADD_PACK}" > /dev/null
local_pack_info=$?


if [ $local_conf_info -ne 0 ];then
	echo "Append ${CONFLINE} in the local.conf file"
	echo ${CONFLINE} >> conf/local.conf
	
else
	echo "${CONFLINE} already exists in the local.conf file"
fi

if [ $local_image_info -ne 0 ];then 
    echo "Append ${IMAGE} in the local.conf file"
	echo ${IMAGE} >> conf/local.conf
else
	echo "${IMAGE} already exists in the local.conf file"
fi

if [ $local_memory_info -ne 0 ];then
    echo "Append ${MEMORY} in the local.conf file"
	echo ${MEMORY} >> conf/local.conf
else
	echo "${MEMORY} already exists in the local.conf file"
fi
#Rev 2
if [ $local_distro_info -ne 0 ];then
    echo "Append ${DISTRO_F} in the local.conf file"
	echo ${DISTRO_F} >> conf/local.conf
else
	echo "${DISTRO_F} already exists in the local.conf file"
fi

if [ $local_imgadd_info -ne 0 ];then
    echo "Append ${IMAGE_ADD} in the local.conf file"
	echo ${IMAGE_ADD} >> conf/local.conf
else
	echo "${IMAGE_ADD} already exists in the local.conf file"
fi
#Rev 2

if [ $local_licn_info -ne 0 ];then
    echo "Append ${LICENCE} in the local.conf file"
	echo ${LICENCE} >> conf/local.conf
else
	echo "${LICENCE} already exists in the local.conf file"
fi

if [ $local_imgf_info -ne 0 ];then
    echo "Append ${IMAGE_F} in the local.conf file"
	echo ${IMAGE_F} >> conf/local.conf
else
	echo "${IMAGE_F} already exists in the local.conf file"
fi

#Qt5 Rev 3
if [ $local_pack_info -ne 0 ];then
    echo "Append ${ADD_PACK} in the local.conf file"
	echo ${ADD_PACK} >> conf/local.conf
else
	echo "${ADD_PACK} already exists in the local.conf file"
fi

bitbake-layers show-layers | grep "meta-raspberrypi" > /dev/null
layer_info=$?

bitbake-layers show-layers | grep "meta-python" > /dev/null
layer_python_info=$?

bitbake-layers show-layers | grep "meta-oe" > /dev/null
layer_metaoe_info=$?

bitbake-layers show-layers | grep "meta-networking" > /dev/null
layer_networking_info=$?

#Rev 3 Qt5
bitbake-layers show-layers | grep "meta-qt5" > /dev/null
layer_info_qt=$?

if [ $layer_info_qt -ne 0 ];then
	echo "Adding meta-qt5 layer"
	bitbake-layers add-layer ../meta-qt5
else
	echo "layer meta-qt5 already exists"
fi
#Rev 3 Qt5

if [ $layer_metaoe_info -ne 0 ];then
    echo "Adding meta-oe layer"
	bitbake-layers add-layer ../meta-openembedded/meta-oe
else
	echo "layer meta-oe already exists"
fi


if [ $layer_python_info -ne 0 ];then
    echo "Adding meta-python layer"
	bitbake-layers add-layer ../meta-openembedded/meta-python
else
	echo "layer meta-python already exists"
fi


if [ $layer_networking_info -ne 0 ];then
    echo "Adding meta-networking layer"
	bitbake-layers add-layer ../meta-openembedded/meta-networking
else
	echo "layer meta-networking already exists"
fi

if [ $layer_info -ne 0 ];then
	echo "Adding meta-raspberrypi layer"
	bitbake-layers add-layer ../meta-raspberrypi
else
	echo "layer meta-raspberrypi already exists"
fi

#--------------QT5 Support--------------------
bitbake-layers show-layers | grep "meta-multimedia" > /dev/null
layer_info=$?

if [ $layer_info -ne 0 ];then
	echo "Adding meta-multimedia layer"
	bitbake-layers add-layer ../meta-openembedded/meta-multimedia
else
	echo "layer meta-multimedia already exists"
fi

bitbake-layers show-layers | grep "meta-gui" > /dev/null
layer_info=$?

if [ $layer_info -ne 0 ];then
	echo "Adding meta-gui layer"
	bitbake-layers add-layer ../meta-gui
else
	echo "meta-gui layer already exists"
fi
#--------------QT5 Support--------------------

#--------------Socket Support--------------------

bitbake-layers show-layers | grep "meta-cserver" > /dev/null
layer_info=$?

if [ $layer_info -ne 0 ];then
	echo "Adding meta-cserver layer"
	bitbake-layers add-layer ../meta-cserver
else
	echo "meta-cserver layer already exists"
fi

bitbake-layers show-layers | grep "meta-client" > /dev/null
layer_info=$?

if [ $layer_info -ne 0 ];then
	echo "Adding meta-client layer"
	bitbake-layers add-layer ../meta-client
else
	echo "meta-client layer already exists"
fi

#--------------Socket Support--------------------

set -e
bitbake core-image-sato
