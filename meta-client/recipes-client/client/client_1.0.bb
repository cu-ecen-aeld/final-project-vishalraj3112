#
# This file was derived from the 'Hello World!' example recipe in the
# Yocto Project Development Manual.
#

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "git://github.com/cu-ecen-aeld/finalproject-vishal-anshul-shared.git;protocol=ssh;branch=master"

PV = "1.0+git${SRCPV}"
#socket gui working on dummy temp data commit below
SRCREV = "797aa06ba0951f4359823e2c4e39f44930c6d3cf" 
S = "${WORKDIR}/git/client"


#inherit autotools

FILES_${PN} += "${bindir}/client"


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
	install -m 0755 ${S}/client ${D}${bindir}/
	
	#install destination directory for init script
	#install -d ${D}${sysconfdir}/init.d
	#install -m 0755 ${S}/aesdsocket-start-stop.sh ${D}${sysconfdir}/init.d
}

# The autotools configuration I am basing this on seems to have a problem with a race condition when parallel make is enabled
PARALLEL_MAKE = ""
