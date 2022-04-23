SUMMARY = "QT Example Recipe"
LICENSE = "CLOSED"

SRC_URI = "file://window.h \ 
	file://file-reader.cpp \ 
	file://mainwindow.ui \ 
	file://main.cpp \ 
	file://window.cpp \ 
	file://SampleProject.pro.user \ 
	file://components.h \ 
	file://mainwindow.cpp \ 
	file://components.cpp \ 
	file://file-reader.h \ 
	file://SampleProject.pro \ 
	file://mainwindow.h"

DEPENDS += "qtbase" 

RDEPENDS_${PN} += "qtwayland" 

FILES_${PN} += "${bindir}/SampleProject" 

S = "${WORKDIR}" 

# Build-time dependency
DEPENDS += "libgpiod"
#TARGET_LDFLAGS += "-lgpiod"

do_install:append () {
	 install -d ${D}${bindir} 
	 install -m 0755 SampleProject ${D}${bindir}/
} 

inherit qmake5
