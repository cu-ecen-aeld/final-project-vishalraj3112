#
# This file was derived from the 'Hello World!' example recipe in the
# Yocto Project Development Manual.
#

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "git://github.com/cu-ecen-aeld/assignments-3-and-later-vishalraj3112.git;protocol=ssh;branch=main"
PV = "1.0+git${SRCPV}"
SRCREV = "b148cef251136370c966aad8be22ba38452c2e4c"

S = "${WORKDIR}/git/server_new"

#inherit autotools

FILES_${PN} += "${bindir}/server"


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
	install -m 0755 ${B}/aesdsocket_new ${D}${bindir}/	
	
}

# The autotools configuration I am basing this on seems to have a problem with a race condition when parallel make is enabled
PARALLEL_MAKE = ""
