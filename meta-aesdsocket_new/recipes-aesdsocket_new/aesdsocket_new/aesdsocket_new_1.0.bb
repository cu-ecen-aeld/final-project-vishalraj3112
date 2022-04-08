#
# This file was derived from the 'Hello World!' example recipe in the
# Yocto Project Development Manual.
#

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "git://github.com/cu-ecen-aeld/assignments-3-and-later-vishalraj3112.git;protocol=ssh;branch=main"
#SRC_URI = "https://github.com/cu-ecen-aeld/assignments-3-and-later-vishalraj3112.git;branch=main"

PV = "1.0+git${SRCPV}"
SRCREV = "8c9b76b09c69c4040ea700b603bb66daed2d8dd1"
#SRC_URI[sha256sum] = "92a7ac3d518f0a9606b76422f39d4b592820bc3e839133d803bda3909ef69aaa"


S = "${WORKDIR}/git/server_new"
#S = "${workdir}"


#inherit autotools

FILES_${PN} += "${bindir}/aesdsocket_new"


# TODO: customize these as necessary for any libraries you need for your application
TARGET_LDFLAGS += "-pthread -lrt"
#------------------------------------

do_configure () {
	:
}

do_compile () {
	oe_runmake
}

do_install () {
	# TODO: Install your binaries/scripts here.
	# Be sure to install the target directory with install -d first
	# Yocto variables ${D} and ${S} are useful here, which you can read about at 
	# https://www.yoctoproject.org/docs/latest/ref-manual/ref-manual.html#var-D
	# and
	# https://www.yoctoproject.org/docs/latest/ref-manual/ref-manual.html#var-S
	# See example at https://github.com/cu-ecen-aeld/ecen5013-yocto/blob/ecen5013-hello-world/meta-ecen5013/recipes-ecen5013/ecen5013-hello-world/ecen5013-hello-world_git.bb
	
	#install dest directory /usr/bin
	install -d ${D}${bindir}
	install -m 0755 ${S}/aesdsocket_new ${D}${bindir}/
	
	#install destination directory for init script
	#install -d ${D}${sysconfdir}/init.d
	#install -m 0755 ${S}/aesdsocket-start-stop.sh ${D}${sysconfdir}/init.d
}

# The autotools configuration I am basing this on seems to have a problem with a race condition when parallel make is enabled
PARALLEL_MAKE = ""
