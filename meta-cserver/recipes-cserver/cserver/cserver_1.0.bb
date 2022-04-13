#
# This file was derived from the 'Hello World!' example recipe in the
# Yocto Project Development Manual.
#

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "git://github.com/cu-ecen-aeld/finalproject-vishal-anshul-shared.git;protocol=ssh;branch=master"

PV = "1.0+git${SRCPV}"
SRCREV = "abb416c6d3c64826413bfad7deaece54ce33c2da"

S = "${WORKDIR}/git/server-new"


#inherit autotools

FILES_${PN} += "${bindir}/cserver"


# TODO: customize these as necessary for any libraries you need for your application
TARGET_LDFLAGS += "-pthread -lrt"

do_configure () {
	:
}

do_compile () {
	oe_runmake
}

do_install () {
	
	#install dest directory /usr/bin
	install -d ${D}${bindir}
	install -m 0755 ${S}/server ${D}${bindir}/
	
	#install destination directory for init script
	#install -d ${D}${sysconfdir}/init.d
	#install -m 0755 ${S}/aesdsocket-start-stop.sh ${D}${sysconfdir}/init.d
}

# The autotools configuration I am basing this on seems to have a problem with a race condition when parallel make is enabled
PARALLEL_MAKE = ""
