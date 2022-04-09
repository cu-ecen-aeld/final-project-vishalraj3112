#
# This file was derived from the 'Hello World!' example recipe in the
# Yocto Project Development Manual.
#

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

#SRC_URI = "git://github.com/cu-ecen-aeld/assignments-3-and-later-vishalraj3112.git;protocol=ssh;branch=main"
SRC_URI = "git://github.com/cu-ecen-aeld/finalproject-vishal-anshul-shared.git;protocol=ssh;branch=main"


PV = "1.0+git${SRCPV}"
#SRCREV = "8c9b76b09c69c4040ea700b603bb66daed2d8dd1"
SRCREV = "1d995b4d53bd92ef2487bb9e3af740772b6fcb39"

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
	install -m 0755 ${S}/aesdsocket-new ${D}${bindir}/
	
	#install destination directory for init script
	#install -d ${D}${sysconfdir}/init.d
	#install -m 0755 ${S}/aesdsocket-start-stop.sh ${D}${sysconfdir}/init.d
}

# The autotools configuration I am basing this on seems to have a problem with a race condition when parallel make is enabled
PARALLEL_MAKE = ""
